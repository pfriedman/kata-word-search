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
    coordinates_for_first_letter(word).each do |x, y|

      search_directions.each do |method_name|
        coordinates = send(method_name.to_sym, word: word, x: x, y: y)
        return coordinates if word_at(coordinates: coordinates) == word

        coordinates = send("reverse_#{method_name}".to_sym, word: word, x: x, y: y)
        return coordinates if word_at(coordinates: coordinates) == word
      end
    end

    return nil
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

  def reverse_horizontal_coordinates(word:, x:, y:)
    word.length.times.inject([]) do |coordinates, i|
      coordinates << [x - i, y]
    end
  end

  def vertical_coordinates(word:, x:, y:)
    word.length.times.inject([]) do |coordinates, i|
      coordinates << [x, y + i]
    end
  end

  def reverse_vertical_coordinates(word:, x:, y:)
    word.length.times.inject([]) do |coordinates, i|
      coordinates << [x, y - i]
    end
  end

  def descending_coordinates(word:, x:, y:)
    word.length.times.inject([]) do |coordinates, i|
      coordinates << [x + i, y + i]
    end
  end

  def reverse_descending_coordinates(word:, x:, y:)
    word.length.times.inject([]) do |coordinates, i|
      coordinates << [x - i, y + i]
    end
  end

  def ascending_coordinates(word:, x:, y:)
    word.length.times.inject([]) do |coordinates, i|
      coordinates << [x + i, y - i]
    end
  end

  def reverse_ascending_coordinates(word:, x:, y:)
    word.length.times.inject([]) do |coordinates, i|
      coordinates << [x - i, y - i]
    end
  end

  def word_at(coordinates:)
    coordinates.inject([]) do |letters, coordinate|
      letters << reader.letter_at(x: coordinate[0], y: coordinate[1])
    end.join
  end

  def search_directions
    %w[ horizontal_coordinates vertical_coordinates descending_coordinates ascending_coordinates ]
  end

end
