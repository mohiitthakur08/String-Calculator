require "rails_helper"

RSpec.describe StringCalculator::Calculator do
  describe ".add" do
    it "returns 0 for an empty string or nil" do
      expect(described_class.add("")).to eq(0)
      expect(described_class.add(nil)).to eq(0)
    end

    it "returns the number for a single number" do
      expect(described_class.add("1")).to eq(1)
      expect(described_class.add("42")).to eq(42)
    end

    it "sums two comma-separated numbers" do
      expect(described_class.add("1,5")).to eq(6)
    end

    it "sums any amount of numbers" do
      expect(described_class.add("1,2,3,4,5")).to eq(15)
    end

    it "handles new lines between numbers (in addition to commas)" do
      expect(described_class.add("1\n2,3")).to eq(6)
    end

    it "supports custom single-character delimiter via //;\\n syntax" do
      expect(described_class.add("//;\n1;2;3")).to eq(6)
    end

    it "allows newlines mixed with custom delimiter as well" do
      expect(described_class.add("//|\n1|2\n3|4")).to eq(10)
    end

    it "raises on a single negative number with correct message" do
      expect {
        described_class.add("-2")
      }.to raise_error(
        StringCalculator::Calculator::NegativeNumbersError,
        "negative numbers not allowed -2"
      )
    end

    it "raises listing all negative numbers when multiple are present" do
      expect {
        described_class.add("-1,2,-3\n4")
      }.to raise_error(
        StringCalculator::Calculator::NegativeNumbersError,
        "negative numbers not allowed -1,-3"
      )
    end
  end
end
