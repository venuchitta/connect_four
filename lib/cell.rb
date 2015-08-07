class Cell

  attr_reader :row, :column
  attr_accessor :state

  def initialize (row, column)
    @row    = row
    @column = column
    @state  = '. '
  end
end