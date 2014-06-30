module GitAliases
  class Installation
    class Basics
      def initialize(options={})
        @installation_root = options[:installation_root]
        @gitconfig         = options[:gitconfig]
      end

      def installed?
        gitconfig.exists?("alias-config.alias-root", Regexp.escape(installation_root))
      end

      def install
        return if installed?
        puts "Installing git_aliases in '#{installation_root}'"
        gitconfig.set("alias-config.alias-root", installation_root)
      end

      def uninstall
        return unless installed?
        puts "Uninstalling git_aliases"
        gitconfig.unset("alias-config.alias-root", Regexp.escape(installation_root))
      end

      private

      attr_reader :installation_root, :gitconfig
    end
  end
end
