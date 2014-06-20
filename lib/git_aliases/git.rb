require 'git_aliases/git/return_value'
require 'open3'

module GitAliases
  module Git
    CommandFailedError = Class.new(StandardError)

    def self.run(*args)
      debug_command(args)

      result = ReturnValue.new(*Open3.capture2e("git", *args))

      debug_result(result)

      result
    end

    def self.run!(*args)
      result = run(*args)
      unless result.success?
        raise CommandFailedError.new("Command: `git #{args.join(" ")}` failed with exit status #{result.status}:\n#{result.output}")
      end
      return result
    end

    def self.interactive_run(*args)
      debug_command(args)
      system("git", *args)
    end

    def self.interactive_run!(*args)
      result = interactive_run(*args)
      unless result
        raise CommandFailedError.new("Interactive command: `git #{args.join(" ")}` failed!")
      end
      return result
    end

    private

    def self.debug_command(args)
      puts "Running git with #{args.inspect}" if GitAliases.debug?
    end

    def self.debug_result(result)
      puts result.output if GitAliases.debug?
    end
  end
end
