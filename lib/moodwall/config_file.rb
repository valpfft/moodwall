require "yaml"
require "fileutils"

module Moodwall
  class ConfigFile
    DIRECTORY = "#{ Dir.home }/.config/moodwall".freeze
    FILE      = "config.yml".freeze

    attr_reader :data, :path

    def initialize
      @path = File.join(DIRECTORY, FILE)
      create_directory && prepare_file
      @data = YAML.safe_load(File.read(path)) || {}
    end

    private

    def create_directory
      FileUtils.mkdir_p(DIRECTORY)
    end

    def prepare_file
      FileUtils.touch(path)
    end
  end
end
