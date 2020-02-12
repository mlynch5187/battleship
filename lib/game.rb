require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :ai_board,
              :ai_cruiser,
              :ai_submarine,
              :human_board,
              :human_cruiser,
              :human_submarine

  def initialize
    @ai_board = Board.new()
    @ai_cruiser = Ship.new("Cruiser", 3)
    @ai_submarine = Ship.new("Submarine", 2)
    @human_board = Board.new()
    @human_cruiser = Ship.new("Cruiser", 3)
    @human_submarine = Ship.new("Submarine", 2)
    @coordinates_to_fire_on = ''
    @coordinates_computer_fires_on = ''
  end

  def start
    puts "WELCOME TO BATTLESHIP"
    puts "Enter p to play. Enter q to quit"

    your_response = gets.chomp
      if your_response.upcase == "P"
        play_game
      elsif your_response.upcase == "Q"
        start
      else
        puts "Those are invalid coordinates. Try again"
        start
      end
  end

  def play_game
    place_computer_ships(@ai_cruiser)
    place_computer_ships(@ai_submarine)
    place_user_ships(@human_cruiser)
    place_user_ships(@human_submarine)
  end

  def place_computer_ships(ship)
    coordinates = []
    if @ai_board.valid_placement?(ship, coordinates)
      @ai_board.place(ship, coordinates)
    else
      coordinates = @ai_board.cells.keys.sample(ship.length)
      until @ai_board.valid_placement?(ship, coordinates)
        coordinates = @ai_board.cells.keys.sample(ship.length)
      end
      @ai_board.place(ship, coordinates)
    end
    if ship == @ai_submarine
      computer_done_placing
    end
  end

  def computer_done_placing
    puts "I have laid my ships on the grid."
    puts "You now need to lay out your ships."
    puts "The Cruiser is three units long and the submarine is two units long."
  end

  def place_user_ships(ship)
    puts @human_board.render(true)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)"
    puts "Enter your coordinates in order, and without commas"
    user_coordinates = gets.chomp
    user_coordinates_array = user_coordinates.upcase.split(" ")
    until @human_board.valid_placement?(ship, user_coordinates_array)
      puts "These are invalid coordinates, please try again!"
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)"
      puts "Enter your coordinates in order, and without commas"
      user_coordinates = gets.chomp
      user_coordinates_array = user_coordinates.upcase.split(" ")
    end
    @human_board.place(ship, user_coordinates_array)
    if ship.name == "Submarine"
      player_done_placing
    end
  end

  def player_done_placing
    puts "I have placed my ships"
    turn
  end

  def turn
    until @human_cruiser.sunk? && @human_submarine.sunk? || @ai_cruiser.sunk? && @ai_submarine.sunk?
      board_display
      player_take_turn
      computer_take_turn
      shot_results(@coordinates_to_fire_on, @coordinates_computer_fires_on)
    end
    game_over
  end

  def player_take_turn
    puts "Enter the coordinate for your shot"
    @coordinates_to_fire_on = gets.chomp.upcase
    until @ai_board.valid_coordinate?(@coordinates_to_fire_on)
      puts "Please enter a valid coordinate:"
      @coordinates_to_fire_on = gets.chomp.upcase
    end
    @ai_board.cells[@coordinates_to_fire_on.upcase].fire_upon
  end

  def computer_take_turn
    @coordinates_computer_fires_on = @ai_board.cells.keys.sample
    until @human_board.cells[@coordinates_computer_fires_on].fired_upon? == false
      @coordinates_computer_fires_on = @ai_board.cells.keys.sample
    end
    @human_board.cells[@coordinates_computer_fires_on].fire_upon
  end

  def board_display
    puts "=============OPPONENT'S BOARD============="
    puts @ai_board.render
    puts "==============YOUR BOARD=============="
    puts @human_board.render(true)
  end

  def shot_results(coordinates_to_fire_upon, coordinates_computer_fires_upon)
    user_results(coordinates_to_fire_upon)
    computer_results(coordinates_computer_fires_upon)
  end

  def user_results(coordinates_to_fire_upon)
    if @ai_board.cells[coordinates_to_fire_upon].fired_upon? && @ai_board.cells[coordinates_to_fire_upon].ship == nil
      puts "Your shot on #{coordinates_to_fire_upon} was a miss"
    elsif @ai_board.cells[coordinates_to_fire_upon].fired_upon? && @ai_board.cells[coordinates_to_fire_upon].ship.sunk?
      puts "Your shot on #{coordinates_to_fire_upon} sunk an enemy ship"
    else
      puts "Your shot on #{coordinates_to_fire_upon} hit an enemy ship"
    end
  end

  def computer_results(coordinates_computer_fires_upon)
    if @human_board.cells[coordinates_computer_fires_upon].fired_upon? && @human_board.cells[coordinates_computer_fires_upon].ship == nil
      puts "My shot on #{coordinates_computer_fires_upon} was a miss"
    elsif @human_board.cells[coordinates_computer_fires_upon].fired_upon? && @human_board.cells[coordinates_computer_fires_upon].ship.sunk?
      puts "My shot on #{coordinates_computer_fires_upon} sunk one of your ships"
    else
      puts "My shot on #{coordinates_computer_fires_upon} hit one of your ships"
    end
  end

  def game_over
    board_display
    if @human_cruiser.sunk? && @human_submarine.sunk?
        puts "I win. That was too easy. Where'd you learn those lame skills?"
        new_game
    else @ai_cruiser.sunk? && @ai_submarine.sunk?
        puts "It looks like you got lucky and found a way to win."
        new_game
    end
  end

  def new_game
    puts "Would you like to play another round? (y/n)"
    user_input = gets.chomp.upcase
    if user_input == "Y"
      start
    elsif user_input == "N"
      puts "Thanks for playing!"
    else
      puts "Invalid input."
      new_game
    end
  end
end
