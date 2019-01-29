class Searcher
  attr_reader :reader

  # @param [String] file_path
  def initialize(file_path:)
    @reader = Reader.new(file_path: file_path)
  end
end
