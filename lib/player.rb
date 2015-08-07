require 'set'

class Player
  attr_reader :symbol, :rows, :columns, :num_pieces_to_win

  def initialize(symbol, rows, columns, num_pieces_to_win)
    @symbol = symbol
    @rows = rows
    @columns = columns
    @num_pieces_to_win = num_pieces_to_win
    @horizontal = Hash.new{|hash, key| hash[key] = Set.new}  ## Uses this hash to find out if the player is present around
    @vertical = Hash.new{|hash, key| hash[key] = Set.new}
  end

  def check_for_win(row, column)
    memorize(row, column)

    # Worst Case running time is O(n^3) but the average running time is far better due to hash lookup
    check_horizontal_or_vertical(@horizontal, row, column) ||
        check_horizontal_or_vertical(@vertical, column, row) ||
        check_diagonals(row, column)
  end

  private

  def memorize(row, column)
    @horizontal[row] << column
    @vertical[column] << row
  end

  #### Checks if any pieces are horizontal or vertical
  def check_horizontal_or_vertical(state, row, column)
    cols_array = state[row]

    if cols_array.count >= @num_pieces_to_win
      temp = check_if_consecutive(column, cols_array)
      return temp if temp
    end

    false
  end

  def check_if_consecutive(cell, cols_array)
    left_count, right_count = 0, 0

    (cell).upto(@rows) do |element|
      if cols_array.include? element
        left_count += 1
      else
        break
      end
    end

    (cell-1).downto(0) do |element|
      if cols_array.include? element
        right_count += 1
      else
        break
      end
    end

    @num_pieces_to_win <= left_count + right_count
  end

  #### Checks if any pieces are diagonal
  def check_diagonals(row, column)
    one = check_diagonal((diagonal_cells(row,column))[0][0],(diagonal_cells(row,column))[0][1], 0) +
        check_diagonal((diagonal_cells(row,column))[1][0],(diagonal_cells(row,column))[1][1], 1) - 1
    return true if one >= @num_pieces_to_win

    other = check_diagonal((diagonal_cells(row,column))[2][0],(diagonal_cells(row,column))[2][1], 2) +
        check_diagonal((diagonal_cells(row,column))[3][0],(diagonal_cells(row,column))[3][1], 3) - 1
    return true if other >= @num_pieces_to_win

    false
  end

  def check_diagonal(row, column, direction)
    return 1 if !(check_boundaries(row,column) && check_if_present(row,column))
    return 1 + check_diagonal((diagonal_cells(row,column))[direction][0], (diagonal_cells(row,column))[direction][1], direction)
  end

  def check_boundaries(row, column)
    return true if row>=0 && row<@rows && column>=0 && column<@columns
    false
  end

  def check_if_present(row, column)
    if @horizontal.include? row
      return @horizontal[row].include? column
    else
      return false
    end
  end

  def diagonal_cells(row, column)
    [[row + 1, column + 1], [row - 1, column - 1],  [row + 1, column - 1], [row - 1, column + 1]]
  end

end