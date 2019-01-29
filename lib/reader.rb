class Reader
  attr_reader :data

  # @param [String] file_path
  def initialize(file_path:)
    @data = File.readlines(file_path).map(&:strip) if file_path && File.exists?(file_path)
  end
end

