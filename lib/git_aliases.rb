$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

module GitAliases
  def self.debug?
    !!ENV["DEBUG"]
  end
end
