import Foundation
import Danger
import SwiftChecksDangerPlugin

let projectName = "Partial"
let danger = Danger()
// Danger only run for PRs, so if `github` isn't `nil` then
// this is a PR on GitHub. This bool is used to check for
// `swift run danger-swift ci` vs `swift run danger-swift local`
let isPR = danger.github != nil

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
SwiftLint.lint(inline: isPR)
