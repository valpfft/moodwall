require "spec_helper"

describe Moodwall::Mood do
  describe "#name" do
    let!(:name) { "Nature" }
    let!(:mood) { build :mood, name: name }

    it "returns the supplied name" do
      expect(mood.name).to eq name
    end
  end

  describe "#current" do
    context "with current provided" do
      let!(:mood) { build :mood, :current }

      it "returns the current state" do
        expect(mood.current).to eq true
      end
    end

    context "with defaults" do
      let!(:mood) { build :mood }

      it "returns the current state" do
        expect(mood.current).to eq false
      end
    end
  end

  describe ".current" do
    let!(:current_mood) { create :mood, :current }

    it "should return current mood" do
      expect(described_class.current).to eq current_mood
    end
  end

  describe ".set_current" do
    let!(:previous)    { create :mood, :current }
    let!(:new_current) { create :mood, name: "New sheriff" }

    before { described_class.set_current name: "New sheriff" }

    it "should unmark previously selected mood" do
      expect(previous.reload.current).to eq false
    end

    it "should mark newly selected mood as current" do
      expect(new_current.reload.current).to eq true
    end
  end

  describe ".find_by_name" do
    let!(:name) { "Catch me if you can" }
    let!(:mood) { create :mood, name: name }

    subject { described_class.find_by_name(name) }

    it "should find the mood by name" do
      is_expected.to eq mood
    end
  end
end
