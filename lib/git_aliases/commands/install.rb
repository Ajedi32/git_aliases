#!/usr/bin/env ruby

require_relative '../../git_aliases'
require 'git_aliases/installation'

installation = GitAliases::Installation.this

if ARGV.length < 1
  puts 'Usage: git install <alias> [<alias>...]'
  exit false
end

ARGV.each do |new_alias|
  installation.install_alias(new_alias)
end
