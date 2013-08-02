#!/usr/bin/env ruby

class GitAliasesInstallation
  def initialize(root)
    @root = root
  end

  def install_basics
    puts "Installing git_aliases in '#{@root}'"
    system("git", "config", "--global", "alias-config.alias-root", @root)
  end

  def uninstall_basics
    puts "Uninstalling git_aliases"
    system("git", "config", "--global", "--unset", "alias-config.alias-root")
  end

  def uninstall_all
    uninstall_basics
    system("git", "config", "--global", "--unset-all", "include.path", "#{Regexp.escape(@root)}/aliases/.*")
  end

  def install_all
    install_basics
    system("git", "config", "--global", "include.path", File.join(@root, "aliases", "all.gitconfig"))
  end
end

installation = GitAliasesInstallation.new(File.expand_path(File.dirname(__FILE__)))

case ARGV[0]
when "install"
  installation.install_all
when "uninstall"
  installation.uninstall_all
else
  puts "Usage: #{$0} (install|uninstall)"
end
