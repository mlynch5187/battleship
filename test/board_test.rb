require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'

class BoardTest < MiniTest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_board_has_cells
    assert_instance_of Hash, @board.cells
    assert_instance_of Cell, @board.cells["A1"]
    assert_equal 16, @board.cells.length
  end

  def test_cell_coordinates_are_valid
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_that_ships_must_take_up_as_many_coordinates_as_their_length
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@submarine, ["A2", "A3"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
  end
end
# First, the number of coordinates in the array should be the same as the length of the ship:
#
# pry(main)> board.valid_placement?(cruiser, ["A1", "A2"])
# # => false
#
# pry(main)> board.valid_placement?(submarine, ["A2", "A3", "A4"])
# # => false


# Next, make sure the coordinates are consecutive:
#
# pry(main)> board.valid_placement?(cruiser, ["A1", "A2", "A4"])
# # => false
#
# pry(main)> board.valid_placement?(submarine, ["A1", "C1"])
# # => false
#
# pry(main)> board.valid_placement?(cruiser, ["A3", "A2", "A1"])
# # => false
#
# pry(main)> board.valid_placement?(submarine, ["C1", "B1"])
# # => false


# Finally, coordinates can’t be diagonal:
#
# pry(main)> board.valid_placement?(cruiser, ["A1", "B2", "C3"])
# # => false
#
# pry(main)> board.valid_placement?(submarine, ["C2", "D3"])
# # => false
# If all the previous checks pass then the placement should be valid:
#
# pry(main)> board.valid_placement?(submarine, ["A1", "A2"])
# # => true
#
# pry(main)> board.valid_placement?(cruiser, ["B1", "C1", "D1"])
# # => true
