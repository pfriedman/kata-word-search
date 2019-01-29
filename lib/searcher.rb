class Searcher
  attr_reader :reader

  # @param [String] file_path
  def initialize(file_path:)
    @reader = Reader.new(file_path: file_path)
  end

  ##
  # Returns the x/y coordinates in the search grid for the given word.
  #
  # This method assumes that the word appears once in the search grid.
  #
  # Returns nil if the given word is not found in the grid
  #
  # @param [String] word
  # @return [Array<Array>, NilClass] the x and y coordinates for each letter in the word
  def coordinates_for_word(word:)
    result = nil

    coordinates_for_first_letter(word).each do |x, y|

      horizontal_coordinates = horizontal_coordinates(word: word, x: x, y: y)
      return horizontal_coordinates if word_at(coordinates: horizontal_coordinates) == word

      vertical_coordinates = vertical_coordinates(word: word, x: x, y: y)
      return vertical_coordinates if word_at(coordinates: vertical_coordinates) == word

    end

    result
  end

  private

  def coordinates_for_first_letter(word)
    reader.letters_and_coordinates[word.chars.first]
  end

  def horizontal_coordinates(word:, x:, y:)
    word.length.times.inject([]) do |coordinates, i|
      coordinates << [x + i, y]
    end
  end

  def vertical_coordinates(word:, x:, y:)
    word.length.times.inject([]) do |coordinates, i|
      coordinates << [x, y + i]
    end
  end

  def word_at(coordinates:)
    coordinates.inject([]) do |letters, coordinate|
      letters << reader.letter_at(x: coordinate[0], y: coordinate[1])
    end.join
  end

end
