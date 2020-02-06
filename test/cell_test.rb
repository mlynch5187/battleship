require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_cell_starts_empty
    assert_nil @cell.ship
    assert_equal true, @cell.empty?
  end

  def test_it_can_place_ship
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
  end

  def test_cell_is_not_empty_after_placing_ship
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.empty?
  end

  
  # pry(main)> require './lib/ship'
  # # => true
  #
  # pry(main)> require './lib/cell'
  # # => true
  #
  # pry(main)> cell = Cell.new("B4")
  # # => #<Cell:0x00007f84f0ad4720...>
  #
  # pry(main)> cruiser = Ship.new("Cruiser", 3)
  # # => #<Ship:0x00007f84f0891238...>
  #
  # pry(main)> cell.place_ship(cruiser)
  #
  # pry(main)> cell.fired_upon?
  # # => false
  #
  # pry(main)> cell.fire_upon
  #
  # pry(main)> cell.ship.health
  # # => 2
  #
  # pry(main)> cell.fired_upon?
  # # => true
end
