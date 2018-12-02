require "pstore"

module Moodwall
  class RecordNotFoundError < StandardError; end

  class Record
    attr_writer :repository
    attr_reader :id

    class << self
      def repository
        @repository ||= PStore.new("database.pstore")
      end

      def all
        transaction(read_only: true) do |store|
          Array store[name]
        end
      end

      def find(id)
        all.find { |r| r.id == id.to_i } ||
          raise(RecordNotFoundError, "Can't find the record with id: #{ id }")
      end

      def next_id
        all.map(&:id).max.to_i + 1
      end

      def transaction(read_only: false, &transaction_body)
        Record.repository.transaction(read_only, &transaction_body)
      end
    end

    def ==(other)
      id == other.id
    end

    def save
      @id ||= self.class.next_id
      transaction do |store|
        store[self.class.name] ||= []
        store[self.class.name].delete self
        store[self.class.name] << self
      end
      self
    end

    def delete
      self.class.repository.transaction do |store|
        Array(store[self.class.name]).delete self
      end
    end

    private

    def transaction(**options, &transaction_body)
      self.class.transaction(**options, &transaction_body)
    end
  end
end
