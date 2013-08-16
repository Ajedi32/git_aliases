#!/usr/bin/env ruby

require_relative '../../git_aliases'
require 'git_aliases/git'

Git = GitAliases::Git

if ARGV.length < 2
	puts 'Usage: git do-each <base> <command>'
	exit false
end

original_head = (Git.run("symbolic-ref", "-q", "--short", "HEAD").output! || Git.run("rev-parse", "HEAD").output!).chomp
base = ARGV.shift

Git.run!("rev-list", "HEAD", "^#{base}", "--reverse").output.split("\n").each do |commit|
	Git.run!("checkout", commit)

  puts "\nNow on commit:"
  system("git", "log", "-1")
  puts "\n"

  success = system(*ARGV)
  exit false unless success
end

Git.run!("checkout", original_head)
