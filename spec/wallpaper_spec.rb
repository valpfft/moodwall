require "spec_helper"

describe Moodwall::Wallpaper do
  let!(:mood_id) { 1 }
  let!(:path)    { File.join(Dir.home, "Pictures", "wallpaper.png") }
  let!(:wallpaper) { described_class.new(mood_id: mood_id, path: path) }

  describe "#mood_id" do
    it "should return supplied mood_id" do
      expect(wallpaper.mood_id).to eq mood_id
    end
  end

  describe "#path" do
    it "should return supplied path" do
      expect(wallpaper.path).to eq path
    end
  end

  describe "::sample" do
    subject { described_class.sample }

    it "should return sample object" do
      is_expected.to be_kind_of(described_class)
    end
  end
end