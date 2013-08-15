require "git_aliases/git"
require "git_aliases/git/config"

module GitAliases
  class Installation
    def initialize(root, options={})
      @root = root
      @git_config = options[:git_config] || Git::Config.new
    end

    def install_alias(alias_name)
      install_basics unless installed?
      return true if alias_installed?(alias_name)

      gitconfig_file = alias_file(alias_name)
      @git_config.set("include.path", gitconfig_file, Regexp.escape(gitconfig_file))
    end

    def uninstall_alias(alias_name)
      return true unless alias_installed?(alias_name)

      gitconfig_file = alias_file(alias_name)
      @git_config.unset("include.path", Regexp.escape(gitconfig_file))
    end

    def alias_installed?(alias_name)
      gitconfig_file = alias_file(alias_name)
      @git_config.exists?("include.path", Regexp.escape(gitconfig_file))
    end

    def install
      install_basics
      install_alias("all")
    end

    def uninstall
      @git_config.unset_all("include.path", "#{Regexp.escape(@root)}/aliases/.*")
      uninstall_basics
    end

    def installed?
      @git_config.exists?("alias-config.alias-root", Regexp.escape(@root))
    end

    private

    def install_basics
      return true if installed?
      puts "Installing git_aliases in '#{@root}'"
      @git_config.set("alias-config.alias-root", @root)
    end

    def uninstall_basics
      return true unless installed?
      puts "Uninstalling git_aliases"
      @git_config.unset("alias-config.alias-root", @root)
    end

    def alias_file(alias_name)
      "#{@root}/aliases/#{alias_name}.gitconfig"
    end
  end
end
