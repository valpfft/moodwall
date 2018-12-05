module Moodwall
  class MissingExecutableError < StandardError; end

  class Executable
    attr_reader :command, :arguments

    def initialize(options = {})
      @command   = options.fetch(:command, nil)
      @arguments = options.fetch(:arguments, nil)
      error_if_missing
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
