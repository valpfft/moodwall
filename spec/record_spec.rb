require "spec_helper"

describe Moodwall::Record do
  describe ".repository" do
    it "should initiate default repository" do
      expect(described_class.repository).to be_kind_of(PStore)
    end
  end

  describe ".all" do
    let!(:samples) { Array.new(2) { described_class.new.save } }

    subject { described_class.all }

    it "should return Array of all stored records" do
      is_expected.to be_kind_of Array
      is_expected.to eq samples
    end
  end

  describe ".find!" do
    let!(:record) { described_class.new }

    subject { described_class.find! record.id }

    it "should find record by id" do
      record.save
      is_expected.to eq record
    end

    it "should raise error when no record exists" do
      expect { subject }.to raise_error(Moodwall::RecordNotFoundError)
    end
  end

  describe ".reset" do
    let!(:record) { described_class.new }

    subject { described_class.reset }

    it "should flush all records" do
      expect(described_class.all).to eq []
    end
  end

  describe "#save" do
    let!(:record) { described_class.new }

    it "should return saved object" do
      expect(record.save).to eq record
    end

    it "should set ID for saved object" do
      record.save
      expect(record.id).to be_kind_of Integer
    end

    describe "save record twice" do
      let!(:record) { described_class.new }

      before do
        record.save
        record.save
      end

      it "should store them once" do
        expect(described_class.all.count).to eq 1
      end
    end
  end

  describe "#==" do
    let!(:record)         { described_class.new.save }
    let!(:another_record) { described_class.new.save }

    describe "compare records by id" do
      context "with same record" do
        it { expect(record == record).to eq true }
      end

      context "with different records" do
        it { expect(record == another_record).to eq false }
      end
    end
  end

  describe "#delete" do
    let!(:record)         { described_class.new.save }
    let!(:another_record) { described_class.new.save }

    it "should return deleted object" do
      expect(record.delete).to eq record
    end

    it "should remove object from database" do
      another_record.delete
      expect(described_class.all).to eq [record]
    end
  end
end
