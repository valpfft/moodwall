module Moodwall
  class WallpaperNotFoundError < StandardError; end
  class MissingPathError < StandardError; end
  class MissingFileError < StandardError; end

  class Wallpaper < Record
    include Comparable

    attr_reader :mood_id, :path, :weight

    def initialize(options)
      @path    = options.fetch(:path) { raise(MissingPathError, "Wallpaper path is required") }
      @mood_id = options.fetch(:mood_id) { Moodwall::Mood.current }
      @weight  = options.fetch(:weight, 0)
    end

    class << self
      def sample
        record = within_current_mood.shuffle.sort.first
        raise(WallpaperNotFoundError, "Can't find wallpaper.") if record.nil?
        record.increment_weight!
        record
      end

      def within_current_mood
        mood = Moodwall::Mood.current
        mood.nil? ? all : all.select { |w| w.mood_id == mood.id }
      end

      def list
        all.map(&:path)
      end
    end

    def save
      check_file
      super
    end

    def <=>(other)
      other_weight = other.weight
      if other_weight != weight
        -(other_weight <=> weight)
      else
        [-1, 0, 1].sample
      end
    end

    def increment_weight!
      @weight += 1
      save
    end

    private

    def check_file
      raise(MissingFileError, "Can't find the `#{ path }`") unless File.exist?(path)
    end
  end
end
