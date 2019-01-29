require "spec_helper"

describe Searcher do
  let(:file_path) { "to be set in context blocks" }
  subject { described_class.new(file_path: file_path) }

  describe "#new" do
    it "instantiates a new Searcher object" do
      expect(subject).not_to be_nil
      expect(subject).to be_an_instance_of(Searcher)
    end

    context "given data" do
      let(:file_path) { File.join(File.dirname(__FILE__), "../data/input.txt") }
      it "instantiates a new Searcher object" do
        expect(subject).not_to be_nil
        expect(subject).to be_an_instance_of(Searcher)
      end

      it "creates a reader" do
        expect(subject.reader).not_to be_nil
        expect(subject.reader).to be_an_instance_of(Reader)
      end
    end

    context "given nil for a file path" do
      let(:file_path) { nil }

      it "instance variable reader.data is nil" do
        expect(subject.reader).not_to be_nil
        expect(subject.reader.data).to be_nil
      end
    end

    context "given a bad file path" do
      let(:file_path) { "data/file_does_not_exist" }

      it "instance variable reader.data is nil" do
        expect(subject.reader).not_to be_nil
        expect(subject.reader.data).to be_nil
      end
    end
  end
end
