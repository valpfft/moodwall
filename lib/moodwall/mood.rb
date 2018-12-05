module Moodwall
  class Mood < Record
    attr_reader   :name
    attr_accessor :current

    def initialize(name:, current: false)
      @name    = name
      @current = current
    end

    class << self
      def current
        all.find { |m| m.current == true }
      end

      def set_current(name:)
        previous = current
        if !previous.nil?
          previous.current = false
          previous.save
        end
        new_one = find_by_name(name)
        new_one.current = true
        new_one.save
      end

      def find_by_name(name)
        all.find { |m| m.name.casecmp(name).zero? }
      end
    end
  end
end
