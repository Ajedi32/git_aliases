require "git_aliases/git"
require "git_aliases/git/config"
require "git_aliases/installation/basics"
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
      install unless installed?

      self.alias(alias_name).install
    end

    def uninstall_alias(alias_name)
      self.alias(alias_name).uninstall
    end

    def alias_installed?(alias_name)
      self.alias(alias_name).installed?
    end

    def install
      basics.install
      install_alias("all")
      install_alias("install")
      install_alias("uninstall")
    end

    def uninstall
      Alias.uninstall_all(installation: self)
      basics.uninstall
    end

    def installed?
      basics.installed?
    end

    private

    def basics
      @basics ||= Basics.new(installation_root: root, gitconfig: gitconfig)
    end
  end
end
