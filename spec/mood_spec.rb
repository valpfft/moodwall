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
end
