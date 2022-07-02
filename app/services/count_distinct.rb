class CountDistinct
  def initialize(collection:, column:)
    @collection = collection
    @column = column
  end

  def call
    @collection.count(string_argument)
  end

  private

  def string_argument
    "DISTINCT #{@column}"
  end
end
