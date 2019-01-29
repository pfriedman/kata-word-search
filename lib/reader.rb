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

  def process_word_search_grid
    word_search_grid = []
    data.each_with_index do |line, index|
      next if index == 0
      word_search_grid << line.split(",")
    end
    word_search_grid
  end
  private :process_word_search_grid
end
