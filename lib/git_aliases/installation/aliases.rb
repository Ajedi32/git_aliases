require 'git_aliases/installation/aliases/alias'

module GitAliases
  class Installation
    class Aliases
      def initialize(options={})
        @installation_root = options[:installation_root]
        @gitconfig         = options[:gitconfig]
      end

      def uninstall_all
        gitconfig.unset_all("include.path", Regexp.escape(aliases_path + File::SEPARATOR) + '.*')
      end

      def install(alias_name)
        self.alias(alias_name).install
      end

      def uninstall(alias_name)
        self.alias(alias_name).uninstall
      end

      def installed?(alias_name)
        self.alias(alias_name).installed?
      end

      def alias(name)
        Alias.new(name, aliases_path: aliases_path, gitconfig: gitconfig)
      end
      alias_method :[], :alias

      private

      attr_reader :installation_root, :gitconfig

      def aliases_path
        File.join(installation_root, 'aliases')
      end
    end
  end
end
