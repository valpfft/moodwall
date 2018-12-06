require "spec_helper"

describe Moodwall::Wallpaper do
  describe "#mood_id" do
    let!(:mood_id)   { 1 }
    let!(:wallpaper) { build :wallpaper, mood_id: 1 }

    it "should return supplied mood_id" do
      expect(wallpaper.mood_id).to eq mood_id
    end
  end

  describe "#path" do
    let!(:path)      { "~/example/path" }
    let!(:wallpaper) { build(:wallpaper, path: path) }

    it "should return supplied path" do
      expect(wallpaper.path).to eq path
    end
  end

  describe "::sample" do
    let!(:wallpaper) { create(:wallpaper) }

    subject { described_class.sample }

    it "should return sample object" do
      is_expected.to be_kind_of(described_class)
    end

    it "should increment the weight of selected wallpaper" do
      expect { described_class.sample }.to change { wallpaper.reload.weight }.by(1)
    end
  end

  describe "::list" do
    let!(:first)  { create :wallpaper }
    let!(:second) { create :wallpaper }

    subject { described_class.list }

    it "should list all pathes" do
      is_expected.to include first.path
      is_expected.to include second.path
    end
  end

  describe "#weight" do
    let!(:weight) { 1 }
    let!(:wallpaper) { build :wallpaper, weight: weight }

    it "returns the supplied weight" do
      expect(wallpaper.weight).to eq(weight)
    end
  end

  describe "#<=>" do
    context "with different weights" do
      let!(:first)  { build :wallpaper, weight: 0 }
      let!(:second) { build :wallpaper, weight: 1 }

      it "sorts records by weights, lightest first" do
        expect(first).to be < second
      end
    end

    describe "when weights are equal" do
      let!(:first)  { build :wallpaper }
      let!(:second) { build :wallpaper }

      it "should randomly select direction from [-1, 0, 1]" do
        allow_any_instance_of(Array).to receive(:sample).at_least(:once)
        first <=> second
      end

      context 'when direction returns -1' do
        it "should swap records" do
          allow_any_instance_of(Array).to receive(:sample).and_return(-1)

          expect(first).to be < second
        end
      end

      context 'when #random_direction returns 0' do
        it "should leave records unchanged" do
          allow_any_instance_of(Array).to receive(:sample).and_return(0)

          expect(first).to be == second
        end
      end

      context 'when #random_direction returns -1' do
        it "should swap records" do
          allow_any_instance_of(Array).to receive(:sample).and_return(1)

          expect(first).to be > second
        end
      end
    end
  end

  describe "#increment_weight!" do
    let!(:wallpaper) { build :wallpaper }

    it "should increment the weight" do
      expect { wallpaper.increment_weight! }.to change { wallpaper.weight }.by(1)
    end

    it "should save the record" do
      expect { wallpaper.increment_weight! }.to change { wallpaper.id }
    end
  end
end
