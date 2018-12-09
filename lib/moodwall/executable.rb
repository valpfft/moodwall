module Moodwall
  class MissingExecutableError < StandardError; end

  class Executable
    attr_reader :command, :arguments

    def initialize(options = {}, config = Config.new)
      @config    = config.executable
      @command   = options.fetch(:command, @config.command)
      @arguments = options.fetch(:arguments, @config.arguments)
      error_if_missing
    end

    def self.execute(path)
      new.execute(path)
    end

    def error_if_missing
      raise(MissingExecutableError, "Can't find the `#{ command }`") unless installed?
    end

    def execute(path)
      system "#{ command } #{ arguments } #{ path }"
    end

    private

    def installed?
      system "which #{ command }"
      $?.success?
    end
  end
end
