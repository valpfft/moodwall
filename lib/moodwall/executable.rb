module Moodwall
  class MissingExecutableError < StandardError; end

  class Executable
    attr_reader :command

    def initialize(command)
      @command = command
    end

    def error_if_missing
      raise(MissingExecutableError, "Can't find the `#{ command }`") unless installed?
    end

    private

    def installed?
      system "which #{ command }"
      $?.success?
    end
  end
end
