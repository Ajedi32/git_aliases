#!/usr/bin/env ruby

require_relative '../../git_aliases'
require 'git_aliases/git'

Git = GitAliases::Git

add_options = ["-A"]
add_options += (ARGV.first == '-p' || ARGV.first == '--patch') ? ARGV.shift(1) : []

if ARGV.length < 1
  puts 'Usage: git split [--patch|-p] <files>...'
  exit false
end

original_head = (Git.run("symbolic-ref", "-q", "--short", "HEAD").output! || Git.run("rev-parse", "HEAD").output!).chomp

# Stash working copy in temporary commit
Git.run!("checkout", "-b", "git_aliases/stash")
Git.run!("add", "-A")
working_copy_exists = Git.run("commit", "-m", "Working Directory").success?

# Now do work on a new branch
Git.run!("checkout", "-b", "git_aliases/split_commit", original_head)

Git.run!("reset", "HEAD~")

Git.run!("add", "-AN", "--", *ARGV)

# Add what you want to take out of the original commit
Git.interactive_run!("add", *add_options, "--", *ARGV)

# Create temporary commit from added items
Git.run!("commit", "-m", "Split commit")

Git.run!("reset", "--hard")
Git.run!("clean", "-fd")
Git.run!("checkout", original_head)

# Remove changes from original head
Git.run!("revert", "--no-commit", "git_aliases/split_commit")
Git.run!("commit", "--amend")

# Add changes as new commit
Git.run!("cherry-pick", "git_aliases/split_commit", "--edit")

# Restore working copy
if working_copy_exists
  Git.run!("cherry-pick", "git_aliases/split_commit")
  Git.run!("reset", "HEAD~")
end

# Clean up
Git.run!("branch", "-D", "git_aliases/split_commit")
Git.run!("branch", "-D", "git_aliases/stash")
