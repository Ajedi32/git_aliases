#!/usr/bin/env ruby

require_relative "lib/git_aliases"
require "git_aliases/installation"

installation = GitAliases::Installation.new(File.expand_path(File.dirname(__FILE__)))

case ARGV.shift
when "install"
  if ARGV.length == 0
    installation.install
  else
    ARGV.each do |alias_name|
      installation.install_alias(alias_name)
    end
  end
when "uninstall"
  if ARGV.length == 0
    installation.uninstall
  else
    ARGV.each do |alias_name|
      installation.uninstall_alias(alias_name)
    end
  end
else
  puts "Usage: #{$0} (install|uninstall) [<aliases>...]"
end
