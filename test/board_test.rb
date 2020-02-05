require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'

class BoardTest < MiniTest::Test

  def setup
    @board = Board.new
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_board_has_cells
    assert_instance_of Hash, @board.cells
    assert_instance_of Cell, @board.cells["A1"]
    assert_equal 16, @board.cells.length
  end
end


# pry(main)> board.cells
# # =>
# {
#  "A1" => #<Cell:0x00007ff0728a3f58...>,
#  "A2" => #<Cell:0x00007ff0728a3ee0...>,
#  "A3" => #<Cell:0x00007ff0728a3e68...>,
#  "A4" => #<Cell:0x00007ff0728a3df0...>,
#  "B1" => #<Cell:0x00007ff0728a3d78...>,
#  "B2" => #<Cell:0x00007ff0728a3d00...>,
#  "B3" => #<Cell:0x00007ff0728a3c88...>,
#  "B4" => #<Cell:0x00007ff0728a3c10...>,
#  "C1" => #<Cell:0x00007ff0728a3b98...>,
#  "C2" => #<Cell:0x00007ff0728a3b20...>,
#  "C3" => #<Cell:0x00007ff0728a3aa8...>,
#  "C4" => #<Cell:0x00007ff0728a3a30...>,
#  "D1" => #<Cell:0x00007ff0728a39b8...>,
#  "D2" => #<Cell:0x00007ff0728a3940...>,
#  "D3" => #<Cell:0x00007ff0728a38c8...>,
#  "D4" => #<Cell:0x00007ff0728a3850...>
# }
# Testing the #cells method is a bit tricky because the Cell objects are created in the Board class and not in our tests. We can’t specify exactly what the return value should be because we don’t have reference to the exact cell objects we expect in the hash. Instead, we can assert what we do know about this hash. It’s a hash, it should have 16 key/value pairs, and those keys point to cell objects.
#
# Validating Coordinates
# Our board should be able to tell us if a coordinate is on the board or not:
#
# pry(main)> board.valid_coordinate?("A1")
# # => true
#
# pry(main)> board.valid_coordinate?("D4")
# # => true
#
# pry(main)> board.valid_coordinate?("A5")
# # => false
#
# pry(main)> board.valid_coordinate?("E1")
# # => false
#
# pry(main)> board.valid_coordinate?("A22")
# # => false
