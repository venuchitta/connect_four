require './lib/board'
require './lib/cell'
require './lib/game'
require './lib/player'

def play_game
  print 'Enter number of rows in game: '
  rows = gets.chomp.to_i
  print 'Enter number of columns in game: '
  cols = gets.chomp.to_i
  print 'Enter number of pieces for win in game: '
  num_pieces_to_win = gets.chomp.to_i
  Game.new(rows, cols, num_pieces_to_win).play
end

play_game














































  #
  # def check_horizantal(row,column)
  #   return false if row < num_pieces_to_win-1
  #   piece = grid[row][column].state
  #   (row-1).downto(num_pieces_to_win - row -1 ) do |r|
  #     return false if grid[r][column].state != piece
  #   end
  #   true
  # end
  #
  # def break_if(row, col, piece)
  #   int one_side = 0, other_side = 0
  #
  # end
  #
  # def check_vertical(row, column)
  #   piece = grid[row][column].state
  #   left, right = 1, 1
  #
  #   (column-1).downto(0) do |c|
  #     if c <= 0 || grid[row][c].state != piece
  #       left = column-c
  #       break
  #     end
  #   end
  #
  #   (column+1).upto(columns-1) do |c|
  #     if c >= column || grid[row][c].state != piece
  #       right = c-column
  #       break
  #     end
  #   end
  #   p "#{left} #{right}"
  #   return true if (left+right-1 >= num_pieces_to_win)
  #   false
  # end
