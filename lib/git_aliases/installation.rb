require "git_aliases/git"
require "git_aliases/git/config"

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

    def install_alias(alias_name)
      install_basics unless installed?
      return true if alias_installed?(alias_name)

      gitconfig_file = alias_file(alias_name)
      gitconfig.set("include.path", gitconfig_file, Regexp.escape(gitconfig_file))
    end

    def uninstall_alias(alias_name)
      return true unless alias_installed?(alias_name)

      gitconfig_file = alias_file(alias_name)
      gitconfig.unset("include.path", Regexp.escape(gitconfig_file))
    end

    def alias_installed?(alias_name)
      gitconfig_file = alias_file(alias_name)
      gitconfig.exists?("include.path", Regexp.escape(gitconfig_file))
    end

    def install
      install_basics
      install_alias("all")
      install_alias("install")
      install_alias("uninstall")
    end

    def uninstall
      gitconfig.unset_all("include.path", "#{Regexp.escape(root)}/aliases/.*")
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

    def alias_file(alias_name)
      "#{root}/aliases/#{alias_name}.gitconfig"
    end
  end
end
