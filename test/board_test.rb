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
    @submarine_2 = Ship.new("Submarine", 2)
    @cell_1 = @board.cells["A1"]
    @cell_2 = @board.cells["A2"]
    @cell_3 = @board.cells["A3"]
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_board_has_cells
    assert_instance_of Hash, @board.cells
    assert_instance_of Cell, @board.cells["A1"]
    assert_equal 16, @board.cells.length
  end

  def test_cell_coordinates_must_exist_on_the_board
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

  def test_that_coordinates_must_be_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal true, @board.valid_placement?(@submarine, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "B2", "B3"])
    assert_equal true, @board.valid_placement?(@submarine, ["C1", "D1"])
  end

  def test_cell_coordinates_are_occupied_when_ship_is_placed
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal @cruiser, @cell_1.ship
    assert_equal @cruiser, @cell_2.ship
    assert_equal @cruiser, @cell_3.ship
    assert_equal true, @cell_3.ship == @cell_2.ship
  end

  def test_that_ships_cannot_overlap_cells
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.place(@submarine, ["A1", "B1"])
    @board.place(@submarine_2, ["B3", "B4"])

    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
    assert_equal true, @board.valid_placement?(@submarine_2, ["B3", "B4"])
  end
end
