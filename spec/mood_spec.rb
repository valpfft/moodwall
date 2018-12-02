require "spec_helper"

describe Moodwall::Mood do
  let!(:name) { "Winter" }

  describe "#name" do
    let!(:mood) { described_class.new name: name }

    it "returns the supplied name" do
      expect(mood.name).to eq name
    end
  end

  describe "#current" do
    context "with current provided" do
      let!(:mood) { described_class.new name: name, current: true }
      it "returns the current state" do
        expect(mood.current).to eq true
      end
    end

    context "with defaults" do
      let!(:mood) { described_class.new name: name }

      it "returns the current state" do
        expect(mood.current).to eq false
      end
    end
  end
end
