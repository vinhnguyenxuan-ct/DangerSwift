import Danger
import Foundation

let danger = Danger()

// More example on: https://gist.github.com/candostdagdeviren/e49271e6a4b80f93f3193af89d10f4b1

// * run SwiftLint
let filesToLint = (danger.git.modifiedFiles + danger.git.createdFiles).filter { !$0.contains("Documentation/") }
SwiftLint.lint(.files(filesToLint), inline: true)

// * Warn if big changes
let maxFilesCount = 100
if danger.git.createdFiles.count + danger.git.modifiedFiles.count - danger.git.deletedFiles.count > maxFilesCount {
    warn("Big PR, try to keep changes smaller if you can, currently over \(maxFilesCount)")
}

let swiftFilesWithCopyright = danger.git.createdFiles.filter {
    $0.fileType == .swift && danger.utils.readFile($0).contains("//  Created by")
}

// * Check missing header copyright
if swiftFilesWithCopyright.isEmpty {
    let files = swiftFilesWithCopyright.joined(separator: ", ")
    warn("Missing header copyright, found them in: \(files). Please check again")
}

// * Support running via `danger local`
if danger.github != nil {
    // These checks only happen on a PR
    if danger.github.pullRequest.title.contains("WIP") {
        warn("PR is classed as Work in Progress")
    }
}

let hasAppChanges = !danger.git.modifiedFiles.filter { $0.contains("DangerSwiftTest/") }.isEmpty
let hasTestChanges = !danger.git.modifiedFiles.filter { $0.contains("DangerSwiftTestTets/") }.isEmpty

// * If files changes, tests need to be updated too
if hasAppChanges && !hasTestChanges {
    // Assuming you have a function similar to the Ruby 'fail' function
    warn("Tests were not updated")
}
