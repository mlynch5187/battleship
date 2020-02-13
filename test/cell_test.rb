require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'

class CellTest < Minitest::Test
  def setup
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Cell, @cell_1
  end

  def test_cell_starts_empty
    assert_nil @cell_1.ship
    assert_equal true, @cell_1.empty?
  end

  def test_it_can_place_ship
    @cell_1.place_ship(@cruiser)
    assert_equal @cruiser, @cell_1.ship
  end

  def test_cell_is_not_empty_after_placing_ship
    @cell_1.place_ship(@cruiser)
    assert_equal false, @cell_1.empty?
  end

  def test_cells_begin_unfired_upon
    @cell_1.place_ship(@cruiser)
    assert_equal false, @cell_1.fired_upon?
  end

  def test_ship_loses_1_health_when_fired_upon
    @cell_1.place_ship(@cruiser)
    @cell_1.fire_upon
    assert_equal 2, @cell_1.ship.health
  end

  def test_cell_becomes_fired_upon_when_fired_upon
    @cell_1.place_ship(@cruiser)
    @cell_1.fire_upon
    assert_equal true, @cell_1.fired_upon?
  end

  def test_cell_can_be_rendered
    assert_equal ".", @cell_1.render
    @cell_1.fire_upon
    assert_equal "M", @cell_1.render
  end

  def test_cell_can_render_when_ship_placed
    @cell_2.place_ship(@cruiser)
    assert_equal ".", @cell_2.render
    assert_equal "S", @cell_2.render(true)
  end

  def test_cell_can_render_when_ship_is_hit
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    assert_equal "H", @cell_2.render(true)
  end

  def test_ships_can_be_sunk
    @cell_2.place_ship(@cruiser)

    assert_equal false, @cruiser.sunk?

    @cell_2.fire_upon
    @cell_2.fire_upon
    @cell_2.fire_upon

    assert_equal true, @cruiser.sunk?
  end

  def test_cell_can_render_sunken_ship
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    @cell_2.fire_upon
    @cell_2.fire_upon

    assert_equal true, @cruiser.sunk?
    assert_equal "X", @cell_2.render
  end
end
