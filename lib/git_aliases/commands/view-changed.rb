#!/usr/bin/env ruby

require_relative '../../git_aliases'
require 'git_aliases/git'

Git = GitAliases::Git

diff_args = ARGV.empty? ? ["HEAD~", "HEAD"] : ARGV
viewer = Git.run!("config", "alias-config.viewer").output.strip

puts Git.run("diff", "--name-status", *diff_args).output

Git.run!("diff", "--name-only", *diff_args).output.split("\n").each do |changed_file|
  system(viewer, changed_file)
end
