require "spec_helper"

describe Moodwall::Executable do
  describe "#error_if_missing" do
    let!(:missing_binary_name) { "asdfgjildfjhodishfjg" }
    let!(:binary) { Moodwall::Executable.new(missing_binary_name) }

    it "should raise an error when a binary is missing" do
      expect do
        binary.error_if_missing
      end.to raise_error(Moodwall::MissingExecutableError)
    end
  end
end
