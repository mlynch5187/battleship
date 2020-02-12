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

  # def test_split_coordinates
  #   assert_equal [["A", "1"], ["A", "2"]], @board.split_coordinates(["A1", "A2"])
  #   assert_equal [["A", "1"], ["A", "2"], ["A", "3"]], @board.split_coordinates(["A1", "A2", "A3"])
  # end
  #
  # def test_organize_split_coordinates
  #   split_coordinates = @board.split_coordinates(["A1", "A2"])
  #   assert_equal [["A", "A"], ["1", "2"]], @board.organize_split_coordinates(split_coordinates)
  #   split_coordinates_2 = @board.split_coordinates(["A1", "A2", "A3"])
  #   assert_equal [["A", "A", "A"], ["1", "2", "3"]], @board.organize_split_coordinates(split_coordinates_2)
  # end
  #
  # def test_create_same_coordinate_pair
  #   @board.consecutive_placement?(@submarine, ["A1", "A2"])
  #   @board.split_coordinates(["A1", "A2"])
  #   assert_equal [["A", "A"], ["1", "1"]], @board.create_same_coordinate_pairs
  # end

  # def test_create_consecutive_coordinate_pair
  #   @board.split_coordinates(["A1", "A2"])
  #   @board.organize_split_coordinates
  #   assert_equal [["A", "B"], ["1", "2"]], @board.create_consecutive_coordinate_pairs
  # end

  def test_that_coordinates_must_be_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "B2", "B3"])
    assert_equal true, @board.valid_placement?(@submarine, ["C1", "D1"])
  end

  def test_that_coordinates_can_not_be_diagonal
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "B3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
  end

  def test_cell_coordinates_are_occupied_when_ship_is_placed
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal @cruiser, @cell_1.ship
    assert_equal @cruiser, @cell_2.ship
    assert_equal @cruiser, @cell_3.ship
    assert_equal true, @cell_3.ship == @cell_2.ship
  end

  def test_that_ships_cannot_overlap_cells
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])

    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
  end
end
