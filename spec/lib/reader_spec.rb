require "spec_helper"

describe Reader do
  let(:file_path) { "to be set in context blocks" }
  subject { described_class.new(file_path: file_path) }

  describe "#new" do
    it "instantiates a new Reader object" do
      expect(subject).not_to be_nil
      expect(subject).to be_an_instance_of(Reader)
    end

    context "given a valid input file path" do
      let(:file_path) { File.join(File.dirname(__FILE__), "../data/input.txt") }

      it "instantiates a new Reader object" do
        expect(subject).not_to be_nil
        expect(subject).to be_an_instance_of(Reader)
      end

      it "reads the given file into instance variable called data" do
        expect(subject.data).not_to be_nil
        expect(subject.data).to be_an_instance_of(Array)
      end
    end

    context "given nil for a file path" do
      let(:file_path) { nil }

      it "instance variable data is nil" do
        expect(subject.data).to be_nil
      end
    end

    context "given a bad file path" do
      let(:file_path) { "data/file_does_not_exist" }

      it "instance variable data is nil" do
        expect(subject.data).to be_nil
      end
    end
  end
end

