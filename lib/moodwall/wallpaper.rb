module Moodwall
  class Wallpaper < Record
    attr_reader :mood_id, :path

    def initialize(mood_id:, path:)
      @mood_id = mood_id
      @path    = path
    end

    def self.sample(avoid: nil)
      avoid = [avoid] unless avoid.respond_to? :each
      (all - avoid).sample
    end
  end
end
