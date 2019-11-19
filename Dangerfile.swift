import Foundation
import Danger

protocol FileProvider {
    func getFiles() -> [File]
}

protocol File {
    var path: String { get }
    func getVersions() throws -> [String]
}

public struct InfoPlistFile: File {

    public struct PlistKey: RawRepresentable, ExpressibleByStringLiteral {
        public static var versionNumber: PlistKey = "CFBundleShortVersionString"
        public static var buildNumber: PlistKey = "CFBundleVersion"

        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            self.rawValue = value
        }
    }

    public enum GetVersionsError: Error {
        case noVersionFound
        /// Multiple values for the provided key were found
        case multipleVersionsFound(foundVersions: [String])
        /// A build variable was found but no project file was provided
        /// to allow the variable to be resolved
        case projectFileNotProvided
    }

    public let path: String
    public let plistKey: PlistKey

    /// The path to an `.xcodeproj` file. If this is
    /// set and the value in the info plist file is a build variable
    /// the contents of the project file will be searched
    public let projectFilePath: String?

    private let fileManager: FileManager

    public init(path: String, plistKey: PlistKey, projectFilePath: String? = nil) {
        self.init(path: path, plistKey: plistKey, projectFilePath: projectFilePath, fileManager: .default)
    }

    public init(path: String, plistKey: PlistKey, projectFilePath: String? = nil, fileManager: FileManager) {
        self.path = path
        self.plistKey = plistKey
        self.projectFilePath = projectFilePath
        self.fileManager = fileManager
    }

    public func getVersions() throws -> [String] {
        let plistFile = VersionFile(
            path: path,
            interpreter: .regex(
                "<key>\(plistKey.rawValue)</key>\\s*<string>(.*)</string>"
            ),
            fileManager: fileManager
        )
        let plistVersions = plistFile.getVersions()
        guard let plistVersion = plistVersions.first else {
            throw GetVersionsError.noVersionFound
        }
        guard plistVersions.count == 1 else {
            throw GetVersionsError.multipleVersionsFound(foundVersions: plistVersions)
        }

        if plistVersion.hasPrefix("$("), plistVersion.hasSuffix(")") {
            // This is a build variable
            guard let projectFilePath = projectFilePath else {
                throw GetVersionsError.projectFileNotProvided
            }
            let buildVarible: String = {
                let startIndex = plistVersion.index(plistVersion.indices.startIndex, offsetBy: 2)
                let buildVarible = plistVersion[startIndex...].dropLast()
                return String(buildVarible)
            }()
            let projectFile = VersionFile(
                path: projectFilePath + "/project.pbxproj",
                interpreter: .regex(
                    "\(buildVarible) = (.*);"
                ),
                fileManager: .default
            )
            return projectFile.getVersions()
        } else {
            return [plistVersion]
        }
    }

}

struct InfoPlistFileProvider: FileProvider {

    enum DiscoveryMethod {
        case fileURLs([URL])
        case searchDirectory(_ rootPath: String, fileNames: [String])
    }

    let discoveryMethod: DiscoveryMethod
    let plistKey: InfoPlistFile.PlistKey
    let projectFilePath: String
    private let fileManager: FileManager

    init(discoveryMethod: DiscoveryMethod, plistKey: InfoPlistFile.PlistKey, projectFilePath: String) {
        self.init(
            discoveryMethod: discoveryMethod,
            plistKey: plistKey,
            projectFilePath: projectFilePath,
            fileManager: .default
        )
    }

    init(
        discoveryMethod: DiscoveryMethod,
        plistKey: InfoPlistFile.PlistKey,
        projectFilePath: String,
        fileManager: FileManager
    ) {
        self.discoveryMethod = discoveryMethod
        self.plistKey = plistKey
        self.projectFilePath = projectFilePath
        self.fileManager = fileManager
    }

    func getFiles() -> [File] {
        return fileURLs()
            .map {
                InfoPlistFile(
                    path: $0.path,
                    plistKey: plistKey,
                    projectFilePath: projectFilePath,
                    fileManager: self.fileManager
                )
            }
    }

    private func fileURLs() -> [URL] {
        switch discoveryMethod {
        case .fileURLs(let urls):
            return urls
        case .searchDirectory(let rootPath, let fileNames):
            let rootURL = URL(fileURLWithPath: rootPath)

            guard
                let enumerator = fileManager.enumerator(
                    at: rootURL,
                    includingPropertiesForKeys: nil,
                    options: [.skipsHiddenFiles]
                )
            else { return [] }

            var versions: [URL] = []
            for case let fileURL as URL in enumerator {
                guard let fileName = fileURL.pathComponents.last else { continue }
                guard fileNames.contains(fileName) else { continue}
                versions.append(fileURL)
            }
            return versions
        }
    }

}

public struct VersionFile: File {

    public enum Interpreter {
        case regex(String)
        case closure((String) -> String?)
    }

    public let path: String
    public let interpreter: Interpreter
    private let fileManager: FileManager

    public init(path: String, interpreter: Interpreter) {
        self.init(path: path, interpreter: interpreter, fileManager: .default)
    }

    internal init(path: String, interpreter: Interpreter, fileManager: FileManager) {
        self.path = path
        self.interpreter = interpreter
        self.fileManager = fileManager
    }

    public func getVersions() -> [String] {
        guard let data = fileManager.contents(atPath: path) else {
            warn("Unable to find file at " + path)
            return []
        }
        guard let content = String(data: data, encoding: .utf8) else {
            warn("Could not decode data at " + path + " as UTF8")
            return []
        }

        switch interpreter {
        case .regex(let regex):
            do {
                let regex = try NSRegularExpression(pattern: regex, options: [])
                let matches = regex.matches(
                    in: content,
                    options: [],
                    range: NSRange(location: 0, length: content.count)
                )
                return matches.compactMap { match in
                    guard match.numberOfRanges > 1 else {
                        warn("Failed to find capture group for match \(match)")
                        return nil
                    }
                    let range = match.range(at: 1)
                    let startIndex = content.index(content.startIndex, offsetBy: range.location)
                    let indexPastEnd = content.index(content.startIndex, offsetBy: range.location + range.length)
                    return String(content[startIndex..<indexPastEnd])
                }
            } catch {
                warn("Error creating version check regex from \(regex): \(error.localizedDescription)")
                return []
            }
        case .closure(let closure):
            guard let version = closure(content) else { return [] }
            return [version]
        }
    }
}

let projectName = "Partial"
let danger = Danger()
// Danger only run for PRs, so if `github` isn't `nil` then
// this is a PR on GitHub. This bool is used to check for
// `swift run danger-swift ci` vs `swift run danger-swift local`
let isPR = danger.github != nil

func checkSwiftVersions() {
    check(
        files: [
            VersionFile(
                path: "./\(projectName).xcodeproj/project.pbxproj",
                interpreter: .regex("SWIFT_VERSION = (.*);")
            ),
            VersionFile(
                path: "./\(projectName).podspec",
                interpreter: .regex("\\.swift_version\\s*= \"(.*)\"")
            ),
        ],
        versionKind: "Swift"
    )
}

func checkProjectVersions() {
    check(
        fileProviders: [
            InfoPlistFileProvider(
                discoveryMethod: .searchDirectory("./Sources", fileNames: ["Info.plist"]),
                plistKey: .versionNumber,
                projectFilePath: "./\(projectName).xcodeproj"
            ),
        ],
        files: [
            VersionFile(path: "./\(projectName).podspec", interpreter: .regex("\\.version= \"(.*)\"")),
        ],
        versionKind: "framework"
    )
}

func check(fileProviders: [FileProvider] = [], files: [File] = [], versionKind: String) {
    let files = fileProviders.flatMap { $0.getFiles() } + files
    let versions = files.reduce(Set<String>(), { versions, file in
        do {
            var versions = versions

            for fileVersion in try file.getVersions() {
                if let first = versions.first, !versions.contains(fileVersion) {
                    warn("Found mismatched version. Expected " + first + ", found " + fileVersion + " in " + file.path)
                    versions.insert(fileVersion)
                } else if versions.isEmpty {
                    versions.insert(fileVersion)
                }
            }

            return versions
        } catch {
            fail("Failed to versions from file" + error.localizedDescription)
            return []
        }
    })

    let paths = files.map { $0.path }

    if versions.isEmpty {
        warn("Found no \(versionKind) versions in files: \(paths)")
    } else if !isPR {
        message("All \(versionKind) versions are in-sync: \(paths)")
    }
}

checkSwiftVersions()
checkProjectVersions()
SwiftLint.lint(inline: isPR)
