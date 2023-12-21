import Danger
import Foundation

let danger = Danger()
let git = danger.git
let github = danger.github

// More example on: https://gist.github.com/candostdagdeviren/e49271e6a4b80f93f3193af89d10f4b1

if git.createdFiles.count + git.modifiedFiles.count - git.deletedFiles.count > 300 {
    warn("Big PR, try to keep changes smaller if you can")
}

let swiftFilesWithCopyright = git.createdFiles.filter {
    $0.fileType == .swift
    && danger.utils.readFile($0).contains("//  Created by")
}

if swiftFilesWithCopyright.isEmpty {
    let files = swiftFilesWithCopyright.joined(separator: ", ")
    warn("Missing header copyright, found them in: \(files). Please check again")
}

let filesToLint = (git.modifiedFiles + git.createdFiles).filter { !$0.contains("Documentation/") }
SwiftLint.lint(.files(filesToLint), inline: true)

// Support running via `danger local`
if github != nil {
    // These checks only happen on a PR
    if github.pullRequest.title.contains("WIP") {
        warn("PR is classed as Work in Progress")
    }
}

let hasAppChanges = !git.modifiedFiles.filter { $0.contains("DangerSwiftTest/") }.isEmpty
let hasTestChanges = !git.modifiedFiles.filter { $0.contains("DangerSwiftTestTets/") }.isEmpty

// If changes are more than 10 lines of code, tests need to be updated too
if hasAppChanges && !hasTestChanges {
    // Assuming you have a function similar to the Ruby 'fail' function
    warn("Tests were not updated")
}
