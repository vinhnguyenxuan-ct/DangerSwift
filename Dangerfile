#!/usr/bin/env ruby

declared_non_feature = !!((github.pr_title + github.pr_body) =~ /(?:chore|refactor|trivial)/i)
has_modified_source = git.modified_files.any? { |f| f =~ /.+\.(?:h|m|swift)$/i }
has_story = github.pr_body.include?("carousell.atlassian.net")
summary_is_missing = !!(github.pr_body =~ /\*[\s\r\n]+\*/i)

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

results.each do |violation|
  file = violation["file"].gsub(pwd, "")
  next unless git.modified_files.include? file

  line = violation["line"]
  reason = violation["reason"]
  comment = "#{github.html_link("#{file}#L#{line}")} has linter issue: #{reason}."
  warn(comment, sticky: true)
end