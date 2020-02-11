require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
  attr_reader :user_answer, :computer_board, :user_board

  def initialize()
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

    user_response = gets.chomp

    if user_response == "p"
      play
    elsif user_response == "q"
      start
    else
      "I didn't recognize that key. Press 'p' to play or 'q' to quit."
  end

  def place_computer_ships(ship)
    coordinates = []
    if @computer_board.valid_placement?(ship, coordinates)
      @computer_board.place(ship, coordinates)
    else
      coordinates = @computer_board.cells.keys.sample(ship.length)
    until
      @computer_board.valid_placement?(ship, coordinates)
      coordinates = @computer_board.cells.keys.sample(ship.length)
    end
    @computer_board.place(ship, coordinates)
  end

    if ship == @computer_submarine
      puts "I have laid out my ships. Now it's your turn."
      puts "The cruiser is three units long, and the submarine is two units long."
    end
  end

  def place_user_ships(ship)
    puts @user_board.render(true)
    puts "Enter the coordinates for #{ship.name}. Remember it takes up #{ship.length} units."
  end

  def play

  end

end
end
