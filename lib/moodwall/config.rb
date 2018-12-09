module Moodwall
  class Config
    DEFAULTS = {
      executable: {
        command:   "feh",
        arguments: "--bg-fill"
      }
    }.freeze

    attr_reader :executable

    def initialize(config_file = ConfigFile.new)
      @data       = config_file.data
      @executable = decorate_executable(@data.fetch("executable", {}))
    end

    private

    def decorate_executable(data)
      Struct.new(:command, :arguments).new(
        data.fetch("command", DEFAULTS[:executable][:command]),
        data.fetch("arguments", DEFAULTS[:executable][:arguments])
      )
    end
  end
end
