module GitAliases
  class Installation
    class Aliases
      class Alias
        def initialize(name, options={})
          @name         = name
          @aliases_path = options[:aliases_path]
          @gitconfig    = options[:gitconfig]
        end

        def install
          return if installed?

          gitconfig.set("include.path", file, Regexp.escape(file))
        end

        def uninstall
          return unless installed?

          gitconfig.unset("include.path", Regexp.escape(file))
        end

        def installed?
          gitconfig.exists?("include.path", Regexp.escape(file))
        end

        def exists?
          File.exists? file
        end

        private

        attr_reader :name, :aliases_path, :gitconfig

        def file
          File.join(aliases_path, "#{name}.gitconfig")
        end
      end
    end
  end
end
