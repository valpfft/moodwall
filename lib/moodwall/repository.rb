require "pstore"

module Moodwall
  class Repository
    attr_reader :store

    def initialize(store = PStore.new("database.pstore"))
      @store = store
    end

    def self.store
      new.store
    end

    def self.reset
      store = self.store
      store.transaction do
        store.roots.each { |r| store.delete r }
      end
    end
  end
end
