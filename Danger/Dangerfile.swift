import Foundation
import SwiftChecksDangerPlugin

let projectName = "Partial"

func checkSwiftVersions() {
    SwiftChecks.check(
        files: [
            VersionFile(
                path: "./\(projectName).xcodeproj/project.pbxproj",
                interpreter: .regex("SWIFT_VERSION = (.*);")
            ),
            VersionFile(
                path: "./\(projectName).podspec",
                interpreter: .regex("\\.swift_version\\s*=\\s*\"(.*)\"")
            ),
        ],
        versionKind: "Swift"
    )
}

func checkProjectVersions() {
    SwiftChecks.check(
        fileProviders: [
            InfoPlistFileProvider(
                discoveryMethod: .searchDirectory("./Sources", fileNames: ["Info.plist"]),
                plistKey: .versionNumber,
                projectFilePath: "./\(projectName).xcodeproj"
            ),
        ],
        files: [
            VersionFile(path: "./\(projectName).podspec", interpreter: .regex("\\.version\\s*=\\s*\"(.*)\"")),
        ],
        versionKind: "framework"
    )
}

checkSwiftVersions()
checkProjectVersions()
