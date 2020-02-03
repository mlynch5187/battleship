require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < MiniTest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_ships_have_names
    assert_equal "Cruiser", @cruiser.name
  end

  def test_ships_have_a_length
    assert_equal 3, @cruiser.length
  end

  def test_ships_have_health
    assert_equal 3, @cruiser.health
  end

  def test_ships_being_unsunk
    assert_equal false, @cruiser.sunk?
  end
end

# pry(main)> cruiser.sunk?
# #=> false
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.health
# #=> 2
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.health
# #=> 1
#
# pry(main)> cruiser.sunk?
# #=> false
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.sunk?
# #=> true
