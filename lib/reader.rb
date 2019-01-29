class Reader
  attr_reader :data

  # @param [String] file_path
  def initialize(file_path:)
    @data = File.readlines(file_path).map(&:strip) if file_path && File.exists?(file_path)
  end

  # @return [Array<String>] the words for which to search
  def words
    return nil unless data
    @words ||= data.first.split(",")
  end

  # @return [Array<Array<String>>] the letters in the given word search grid
  def grid
    return nil unless data
    @grid ||= process_word_search_grid
  end

  # Create a Hash where the letter is the key and the value is an array of coordinates where
  # that letter appears in the word search grid
  # @return [Hash<String, Array>]
  def letters_and_coordinates
    @letters_and_coordinates ||= populate_letters_and_coordinates
  end

  # Return the letter at the given x and y coordinates
  # @return [String]
  def letter_at(x:, y:)
    return nil if x.negative? || y.negative?
    return nil if grid[y].nil?
    grid[y][x]
  end

  private

  def process_word_search_grid
    word_search_grid = []
    data.each_with_index do |line, index|
      next if index == 0
      word_search_grid << line.split(",")
    end
    word_search_grid
  end

  def populate_letters_and_coordinates
    hsh = Hash.new { |hsh, key| hsh[key] = [] }
    grid.length.times do |y|
      grid.length.times do |x|
        hsh[letter_at(x: x, y: y)] << [x, y]
      end
    end
    hsh
  end

end
