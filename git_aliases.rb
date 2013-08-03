#!/usr/bin/env ruby

class GitAliasesInstallation
  def initialize(root)
    @root = root
  end

  def install_alias(alias_name)
    install_basics unless installed?
    return true if alias_installed?(alias_name)

    gitconfig_file = alias_file(alias_name)
    system("git", "config", "--global", "include.path", gitconfig_file, Regexp.escape(gitconfig_file))
  end

  def uninstall_alias(alias_name)
    return true unless alias_installed?(alias_name)

    gitconfig_file = alias_file(alias_name)
    system("git", "config", "--global", "--unset", "include.path", Regexp.escape(gitconfig_file))
  end

  def alias_installed?(alias_name)
    gitconfig_file = alias_file(alias_name)
    system("git", "config", "--global", "--get", "include.path", Regexp.escape(gitconfig_file))
  end

  def install
    install_basics
    install_alias("all")
  end

  def uninstall
    system("git", "config", "--global", "--unset-all", "include.path", "#{Regexp.escape(@root)}/aliases/.*")
    uninstall_basics
  end

  def installed?
    system("git", "config", "--global", "--get", "alias-config.alias-root", Regexp.escape(@root))
  end

  private

  def install_basics
    return true if installed?
    puts "Installing git_aliases in '#{@root}'"
    system("git", "config", "--global", "alias-config.alias-root", @root)
  end

  def uninstall_basics
    return true unless installed?
    puts "Uninstalling git_aliases"
    system("git", "config", "--global", "--unset", "alias-config.alias-root", @root)
  end

  def alias_file(alias_name)
    "#{@root}/aliases/#{alias_name}.gitconfig"
  end
end

installation = GitAliasesInstallation.new(File.expand_path(File.dirname(__FILE__)))

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
