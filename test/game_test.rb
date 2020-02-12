require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/game'

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

  def test_game_starts_when_user_inputs_p
    Kernel.stubs(:gets).returns("p")
  end

  # def test_place_user_ships
  #   Game.stubs(:place_user_ships).returns(["A1", "A2", "A3"])
  #   expected =    "  1 2 3 4  \n" +
  #       "A " + @cells["A1"].render(show_ship) + " " + @cells["A2"].render(show_ship) + " " + @cells["A3"].render(show_ship) + " " + @cells["A4"].render(show_ship) + "\n" +
  #       "B " + @cells["B1"].render(show_ship) + " " + @cells["B2"].render(show_ship) + " " + @cells["B3"].render(show_ship) + " " + @cells["B4"].render(show_ship) + "\n" +
  #       "C " + @cells["C1"].render(show_ship) + " " + @cells["C2"].render(show_ship) + " " + @cells["C3"].render(show_ship) + " " + @cells["C4"].render(show_ship) + "\n" +
  #       "D " + @cells["D1"].render(show_ship) + " " + @cells["D2"].render(show_ship) + " " + @cells["D3"].render(show_ship) + " " + @cells["D4"].render(show_ship) + "\n"
  #
  #   assert_equal expected, @game.place_user_ships(@game.human_cruiser)
  # end
end
