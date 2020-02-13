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

  def test_ship_health_decreases_when_hit
    @cruiser.hit

    assert_equal 2, @cruiser.health
  end

  def test_ship_sinks_when_health_reaches_zero
    @cruiser.hit

    assert_equal 2, @cruiser.health

    @cruiser.hit

    assert_equal 1, @cruiser.health

    @cruiser.hit

    assert_equal 0, @cruiser.health
    assert_equal true, @cruiser.sunk?
  end
end
