class Game

  attr_accessor :board, :winner, :current_player, :other_player

  def initialize (rows, columns, num_pieces_to_win)
    @board = Board.new(rows, columns, num_pieces_to_win)
    @current_player = Player.new(:P1, rows, columns, num_pieces_to_win)
    @other_player = Player.new(:P2, rows, columns, num_pieces_to_win)
    @winner = nil
    @num_moves = 0
  end

  def play
    until @winner || @num_moves >= board.rows * board.columns
      board.print_board
      validate_and_place_piece
    end

    board.print_board
    @winner ? (p "The Winner is #{other_player.symbol}") : (p 'Board is Full')
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def validate_and_place_piece
    begin
    column = get_input

    if column >= 0 && column < board.columns
      row = place_piece_in_column(column)
      if row == -1
        raise 'Column is full !!'
      else
        @winner = @current_player if current_player.check_for_win(row, column)
      end
    else
      raise 'Re-Enter Column Number in the Range'
    end

    rescue => e
      p e.message
    end
  end

  private

  def get_input
    print "Enter Column number to place coin (#{current_player.symbol}): "
    gets.chomp.to_i
  end


  def place_piece_in_column(column)
    (0...board.rows).each do |row|

      if board.grid[row][column].state == '. '
        board.place_player(row, column, current_player)
        switch_players
        @num_moves += 1
        return row
      end

    end
    return -1
  end

end