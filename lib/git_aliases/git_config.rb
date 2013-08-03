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
      run_args = ["--get", key]
      unless regex_string.nil?
        run_args << regex_string
      end
      run_config(*run_args)
    end

    def set(key, value, regex_string=nil)
      run_args = [key, value]
      unless regex_string.nil?
        run_args << regex_string
      end
      run_config(*run_args)
    end

    def unset(key, regex_string=nil)
      run_args = ["--unset", key]
      unless regex_string.nil?
        run_args << regex_string
      end
      run_config(*run_args)
    end

    def unset_all(key, regex_string=nil)
      run_args = ["--unset-all", key]
      unless regex_string.nil?
        run_args << regex_string
      end
      run_config(*run_args)
    end

    private

    def run_config(*args)
      system("git", "config", *@scope, *args)
    end
  end
end
