require "open3"

module GitAliases
  class GitConfig
    def initialize(scope="global")
      if ["system", "global", "local"].include?(scope)
        @scope = ["--#{scope}"]
      elsif (File.exists?(scope))
        @scope = ["--file", scope]
      else
        raise ArgumentError.new("The file '#{scope}' does not exist.")
      end
    end

    def exists?(key, regex_string=nil)
      if regex_string
        result = run_config("--get", key, regex_string)
      else
        result = run_config("--get", key)
      end
      return result[:status] == 0
    end

    def set(key, value, regex_string=nil)
      if regex_string
        result = run_config(key, value, regex_string)
      else
        result = run_config(key, value)
      end
      return result[:status] == 0
    end

    def unset(key, regex_string=nil)
      if regex_string
        result = run_config("--unset", key, regex_string)
      else
        result = run_config("--unset", key)
      end
      return result[:status] == 0
    end

    def unset_all(key, regex_string=nil)
      if regex_string
        result = run_config("--unset-all", key, regex_string)
      else
        result = run_config("--unset-all", key)
      end
      return result[:status] == 0
    end

    private

    def run_config(*args)
      output, status = Open3.capture2("git", "config", *@scope, *args)
      return {output: output, status: status}
    end
  end
end
