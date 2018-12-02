module Moodwall
  class Mood < Record
    attr_reader   :name
    attr_accessor :current

    def initialize(name:, current: false)
      @name    = name
      @current = current
    end
  end
end
