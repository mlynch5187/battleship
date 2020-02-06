require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'

class CellTest < Minitest::Test
  def setup
    @cell_1 = Cell.new("B4")
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
  end

  def test_cell_renders_m_when_fired_upon_and_misses
    @cell_1.fire_upon
    assert_equal "M", @cell_1.render
  end

#   pry(main)> cell_1 = Cell.new("B4")
# # => #<Cell:0x00007f84f11df920...>
#
# pry(main)> cell_1.render
# # => "."
#
# pry(main)> cell_1.fire_upon
#
# pry(main)> cell_1.render
# # => "M"
#
# pry(main)> cell_2 = Cell.new("C3")
# # => #<Cell:0x00007f84f0b29d10...>
#
# pry(main)> cruiser = Ship.new("Cruiser", 3)
# # => #<Ship:0x00007f84f0ad4fb8...>
#
# pry(main)> cell_2.place_ship(cruiser)
#
# pry(main)> cell_2.render
# # => "."
#
# # Indicate that we want to show a ship with the optional argument
# pry(main)> cell_2.render(true)
# # => "S"
#
# pry(main)> cell_2.fire_upon
#
# pry(main)> cell_2.render
# # => "H"
#
# pry(main)> cruiser.sunk?
# # => false
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.sunk?
# # => true
#
# pry(main)> cell_2.render
# # => "X"
end
