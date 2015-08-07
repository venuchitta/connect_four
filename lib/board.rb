class Board

  attr_reader :rows, :columns, :num_pieces_to_win, :grid

  def initialize (rows, columns, num_pieces_to_win)
    @rows    = rows
    @columns = columns
    @grid    = create_board
    @num_pieces_to_win  = num_pieces_to_win
  end

  def print_board
    (rows-1).downto(0) do |row|
      (0...columns).each do |col|
        print "#{grid[row][col].state}  "
      end
      print "\n\n"
    end
  end

  def place_player(row, column, current_player)
    grid[row][column].state = current_player.symbol
  end

  private

  def create_board
    board = Array.new(rows) { Array.new(columns) }

    (0...rows).each do |row|
      (0...columns).each do |col|
        board[row][col] = Cell.new(row, col)
      end
    end

    board
  end

end
