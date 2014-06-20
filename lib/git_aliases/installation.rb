require "git_aliases/git"
require "git_aliases/git/config"
require "git_aliases/installation/alias"

module GitAliases
  class Installation
    def self.this
      new(File.expand_path(File.join(File.dirname(__FILE__), "..", "..")))
    end

    attr_reader :root, :gitconfig

    def initialize(root, options={})
      @root      = root
      @gitconfig = options[:gitconfig] || Git::Config.new
    end

    def alias(alias_name)
      Alias.new(alias_name, installation: self)
    end

    def install_alias(alias_name)
      install_basics unless installed?

      self.alias(alias_name).install
    end

    def uninstall_alias(alias_name)
      self.alias(alias_name).uninstall
    end

    def alias_installed?(alias_name)
      self.alias(alias_name).installed?
    end

    def install
      install_basics
      install_alias("all")
      install_alias("install")
      install_alias("uninstall")
    end

    def uninstall
      Alias.uninstall_all(installation: self)
      uninstall_basics
    end

    def installed?
      gitconfig.exists?("alias-config.alias-root", Regexp.escape(root))
    end

    private

    def install_basics
      return true if installed?
      puts "Installing git_aliases in '#{root}'"
      gitconfig.set("alias-config.alias-root", root)
    end

    def uninstall_basics
      return true unless installed?
      puts "Uninstalling git_aliases"
      gitconfig.unset("alias-config.alias-root", root)
    end
  end
end
