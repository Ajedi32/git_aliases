module GitAliases
  class Installation
    class Alias
      attr_reader :name, :installation, :gitconfig

      def self.uninstall_all(options={})
        installation = options[:installation] || GitAliases::Installation.this
        gitconfig    = options[:gitconfig]    || installation.gitconfig

        gitconfig.unset_all("include.path", Regexp.escape(aliases_path(installation) + File::SEPARATOR) + '.*')
      end

      def initialize(name, options={})
        @name         = name
        @installation = options[:installation] || GitAliases::Installation.this
        @gitconfig    = options[:gitconfig]    || installation.gitconfig
      end

      def install
        return true if installed?

        gitconfig.set("include.path", file, Regexp.escape(file))
      end

      def uninstall
        return true unless installed?

        gitconfig.unset("include.path", Regexp.escape(file))
      end

      def installed?
        gitconfig.exists?("include.path", Regexp.escape(file))
      end

      def exists?
        File.exists? file
      end

      private

      def self.aliases_path(installation)
        File.join(installation.root, 'aliases')
      end

      def file
        File.join(Alias.aliases_path(installation), "#{name}.gitconfig")
      end
    end
  end
end
