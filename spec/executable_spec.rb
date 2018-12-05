require "spec_helper"

describe Moodwall::Executable do
  describe "#error_if_missing" do
    let!(:missing_binary_name) { "asdfgjildfjhodishfjg" }

    it "should raise an error when a binary is missing" do
      expect do
        build :executable, command: missing_binary_name
      end.to raise_error(Moodwall::MissingExecutableError)
    end
  end

  describe "#execute" do
    let!(:path)       { "." }
    let!(:executable) { build :executable }

    subject { executable.execute path }

    before do
      allow(executable).to receive(:system).and_return("test_dir")
    end

    it { is_expected.to eq("test_dir") }
  end
end
