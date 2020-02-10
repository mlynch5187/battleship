require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
  attr_reader :user_answer, :computer_board, :user_board

  def initialize()
    @user_answer = gets.chomp
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @user_board = Board.new
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
  end

  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"

    user_response = user_answer

    if user_response == "p"
      play
  end

  def play

    
  end
end
