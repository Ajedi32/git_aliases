require "git_aliases/git"
require "git_aliases/git/config"
require "git_aliases/installation/basics"
require "git_aliases/installation/aliases"

module GitAliases
  class Installation
    def self.this
      new(File.expand_path(File.join(File.dirname(__FILE__), "..", "..")))
    end

    def initialize(root, options={})
      @root      = root
      @gitconfig = options[:gitconfig] || Git::Config.new
    end

    def install
      basics.install
      install_alias('all')
      install_alias('install')
      install_alias('uninstall')
    end

    def uninstall
      aliases.uninstall_all
      basics.uninstall
    end

    def installed?
      basics.installed?
    end

    def install_alias(alias_name)
      ensure_basics_installed
      aliases.install(alias_name)
    end

    def uninstall_alias(alias_name)
      aliases.uninstall(alias_name)
    end

    def alias_installed?(alias_name)
      aliases.installed?(alias_name)
    end

    private

    attr_reader :root, :gitconfig

    def ensure_basics_installed
      basics.install unless basics.installed?
    end

    def aliases
      @aliases ||= Aliases.new(installation_root: root, gitconfig: gitconfig)
    end

    def basics
      @basics ||= Basics.new(installation_root: root, gitconfig: gitconfig)
    end
  end
end
