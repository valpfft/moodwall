require "optparse"

module Moodwall
  class Optparse
    attr_reader :parser, :options

    def initialize(options = ScriptOptions.new)
      @options = options
    end

    def parse(args)
      @args = OptionParser.new do |parser|
        options.define_options(parser)
        parser.parse!(args)
      end
      options
    end

    class ScriptOptions
      attr_accessor :change, :add, :list, :mood,
                    :wallpaper, :path, :mood_name

      def initialize
        self.change    = true
        self.add       = false
        self.list      = false
        self.mood      = false
        self.wallpaper = true
      end

      def define_options(parser)
        parser.banner = "Usage: moodwall [options]\nDefaults: moodwall -c -w"
        parser.separator ""
        parser.separator "Specific options"

        change_option(parser)
        add_option(parser)
        list_option(parser)

        wallpaper_option(parser)
        mood_option(parser)

        parser.separator ""
        parser.separator "Common options:"

        parser.on_tail("-h", "--help", "Show this message") do
          puts parser
          exit
        end

        parser.on_tail("-v", "--version", "Show version") do
          puts Moodwall::VERSION
          exit
        end
      end

      def change_option(parser)
        parser.on("-c", "--change", "Change [target]") do
          self.change = true
          self.add = false
        end
      end

      def add_option(parser)
        parser.on("-a", "--add", "Add [target]") do
          self.add = true
          self.change = false
        end
      end

      def list_option(parser)
        parser.on("-l", "--list", "List [targets]") do
          self.list = true
          self.add = false
          self.change = false
        end
      end

      def wallpaper_option(parser)
        parser.on("-w", "--wallpaper [PATH]", "Specifies wallpaper path") do |path|
          self.wallpaper = true
          self.path = path
        end
      end

      def mood_option(parser)
        parser.on("-m", "--mood [NAME]", "Specifies mood name") do |mood_name|
          self.mood = true
          self.mood_name = mood_name
        end
      end
    end
  end
end
