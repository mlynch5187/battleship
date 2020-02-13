require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/game'
require './lib/cell'
require './lib/board'
require './lib/ship'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_game_exists
    assert_instance_of Game, @game
  end

  def test_game_has_attributes
    assert_instance_of Board, @game.ai_board
    assert_instance_of Ship, @game.ai_cruiser
    assert_instance_of Ship, @game.ai_submarine
    assert_instance_of Ship, @game.human_cruiser
    assert_instance_of Ship, @game.human_submarine
  end

  def test_computer_can_give_coordinates
    @game.stubs(:place_user_ships).returns(["A1", "A2", "A3"])

    assert_equal ["A1", "A2", "A3"], @game.place_user_ships(@game.human_cruiser)
  end
end
