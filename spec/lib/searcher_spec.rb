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

  describe "#coordinates_for_word" do
    let(:file_path) { File.join(File.dirname(__FILE__), "../data/input.txt") }

    context "horizontally" do
      let(:expected_coordinates_for_word) do
        [
          [0, 5],
          [1, 5],
          [2, 5],
          [3, 5],
          [4, 5],
          [5, 5],
        ]
      end

      it "returns the coordinates for a given word" do
        expect(subject.coordinates_for_word(word: "SCOTTY")).to eq(expected_coordinates_for_word)
      end

      it "returns nil for a word not found in the grid" do
        expect(subject.coordinates_for_word(word: "ASDF")).to be_nil
      end
    end

    context "vertically" do
      let(:expected_coordinates_for_word) do
        [
          [0, 6],
          [0, 7],
          [0, 8],
          [0, 9],
          [0, 10],
        ]
      end

      it "returns the coordinates for a given word" do
        expect(subject.coordinates_for_word(word: "BONES")).to eq(expected_coordinates_for_word)
      end
    end

    context "descending along X axis" do
      let(:expected_coordinates_for_word) do
        [
          [2, 1],
          [3, 2],
          [4, 3],
          [5, 4],
          [6, 5],
        ]
      end

      it "returns the coordinates for a given word" do
        expect(subject.coordinates_for_word(word: "SPOCK")).to eq(expected_coordinates_for_word)
      end
    end

    context "ascending along X axis" do
      let(:expected_coordinates_for_word) do
        [
          [10, 14],
          [11, 13],
          [12, 12],
          [13, 11],
          [14, 10],
        ]
      end

      it "returns the coordinates for a given word" do
        expect(subject.coordinates_for_word(word: "HELLO")).to eq(expected_coordinates_for_word)
      end
    end


  end

end
