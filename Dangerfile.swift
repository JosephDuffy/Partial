import Danger

let danger = Danger()
// Danger only run for PRs, so if `github` isn't `nil` then
// this is a PR on GitHub. This bool is used to check for
// `swift run danger-swift ci` vs `swift run danger-swift local`
let isPR = danger.github != nil

SwiftLint.lint(inline: isPR)
