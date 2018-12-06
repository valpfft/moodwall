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

      def choose_current(name:)
        nullify_current
        choose_new_current(name)
      end

      def find_by_name(name)
        all.find { |m| m.name.casecmp(name).zero? }
      end

      def list_names
        all.map(&:name)
      end

      private

      def choose_new_current(name)
        new_one = find_by_name(name)
        new_one.current = true
        new_one.save
      end

      def nullify_current
        previous = current
        unless previous.nil?
          previous.current = false
          previous.save
        end
      end
    end
  end
end
