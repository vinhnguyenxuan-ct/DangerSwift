#!/usr/bin/env ruby

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "WIP"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# Ensure there is a summary for a PR
fail("Please provide a summary in the Pull Request description") if summary_is_missing

# Ensure CHANGELOG is not touched
if git.modified_files.include?("CHANGELOG.md") && github.pr_author != "tflhyl"
  fail("DO NOT update CHANGELOG.md manually, write CHANGES in PR description instead", sticky: true)
end
