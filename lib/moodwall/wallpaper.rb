module Moodwall
  class WallpaperNotFoundError < StandardError; end
  class PathMissingError < StandardError; end

  class Wallpaper < Record
    include Comparable

    attr_reader :mood_id, :path, :weight

    def initialize(options)
      @path    = options.fetch(:path) { raise(PathMissingError) }
      @mood_id = options.fetch(:mood_id, Mood.current)
      @weight  = options.fetch(:weight, 0)
    end

    class << self
      def sample
        record = all.shuffle.sort.first
        raise(WallpaperNotFoundError, "Can't find wallpaper.") if record.nil?
        record.increment_weight!
        record
      end
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
  end
end
