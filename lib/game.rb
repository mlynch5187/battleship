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
    @ai_targeted_cells = ''
    @ai_board = Board.new()
    @ai_cruiser = Ship.new("Cruiser", 3)
    @ai_submarine = Ship.new("Submarine", 2)
    @human_targeted_cells = ''
    @human_board = Board.new()
    @human_cruiser = Ship.new("Cruiser", 3)
    @human_submarine = Ship.new("Submarine", 2)
  end

  def start_game
    puts "================ WELCOME TO BATTLESHIP ================"
    puts "          Press the p key to play or the q key to quit"

    your_response = gets.chomp

    if your_response.upcase == "P"
      play_game
    elsif your_response.upcase == "Q"
      puts "Thanks for playing!"
    else
      puts "Those are invalid coordinates. Try again"
      start_game
    end
  end

  def restart_game
    puts "Wanna play again?"
    puts "Press the p key to play again, or press the q key to quit."

    user_input = gets.chomp.upcase

    if user_input.upcase == "P"
      start_game
    elsif user_input.upcase == "Q"
      puts "Thanks for playing!"
    else
      puts "I didn't understand that. Press the y key to play again or the q key to quit."
      restart_game
    end
  end

  def play_game
    place_ai_ships(@ai_cruiser)
    place_ai_ships(@ai_submarine)
    place_human_ships(@human_cruiser)
    place_human_ships(@human_submarine)
  end

  def board_rendered
    puts "=============OPPONENT'S BOARD============="
    puts @ai_board.render
    puts "==============YOUR BOARD=============="
    puts @human_board.render(true)
  end

  def take_turn
    until @human_cruiser.sunk? && @human_submarine.sunk? || @ai_cruiser.sunk? && @ai_submarine.sunk?
      board_rendered
      player_turn
      ai_turn
      shot_results(@human_targeted_cells, @ai_targeted_cells)
    end
      end_game
  end

  def place_ai_ships(ship)
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

    puts "I have laid my ships on the grid."
    puts "You now need to lay out your ships."
    puts "The Cruiser is three units long and the submarine is two units long."
    end
  end

  def place_human_ships(ship)
    puts @human_board.render(true)
    puts "Enter the coordinates for the #{ship.name}. It takes (#{ship.length} coordinates)"
    puts "Enter your coordinates in order, and without commas"

    human_input = gets.chomp
    user_coordinates = human_input.upcase.split(" ")

    until @human_board.valid_placement?(ship, user_coordinates)
      puts "Those coordinates are invalid. Please enter valid coordinates!"
      puts "Enter the coordinates for the #{ship.name}. It takes up (#{ship.length} coordinates)"
      puts "Enter your coordinates in order, and without commas"
      human_input = gets.chomp
      user_coordinates = human_input.upcase.split(" ")
    end

    @human_board.place(ship, user_coordinates)

    if ship.name == "Submarine"
      puts "I have placed my ships"
      take_turn
    end
  end

  def player_turn
    puts "Enter the coordinate for your shot"

    @human_targeted_cells = gets.chomp.upcase
    until @ai_board.valid_coordinate?(@human_targeted_cells)

      puts "Please enter a valid coordinate:"

      @human_targeted_cells = gets.chomp.upcase
    end
    @ai_board.cells[@human_targeted_cells.upcase].fire_upon
  end

  def ai_turn
    @ai_targeted_cells = @ai_board.cells.keys.sample
    until @human_board.cells[@ai_targeted_cells].fired_upon? == false
      @ai_targeted_cells = @ai_board.cells.keys.sample
    end
    @human_board.cells[@ai_targeted_cells].fire_upon
  end

  def shot_results(human_targeted_cells, ai_targeted_cells)
    user_results(human_targeted_cells)
    computer_results(ai_targeted_cells)
  end

  def user_results(human_targeted_cells)
    if @ai_board.cells[human_targeted_cells].fired_upon? && @ai_board.cells[human_targeted_cells].ship == nil
      puts "Your shot on #{human_targeted_cells} was a miss"
    elsif @ai_board.cells[human_targeted_cells].fired_upon? && @ai_board.cells[human_targeted_cells].ship.sunk?
      puts "Your shot on #{human_targeted_cells} sunk an enemy ship"
    else
      puts "Your shot on #{human_targeted_cells} hit an enemy ship"
    end
  end

  def computer_results(ai_targeted_cells)
    if @human_board.cells[ai_targeted_cells].fired_upon? && @human_board.cells[ai_targeted_cells].ship == nil
      puts "My shot on #{ai_targeted_cells} was a miss"
    elsif @human_board.cells[ai_targeted_cells].fired_upon? && @human_board.cells[ai_targeted_cells].ship.sunk?
      puts "My shot on #{ai_targeted_cells} sunk one of your ships"
    else
      puts "My shot on #{ai_targeted_cells} hit one of your ships"
    end
  end

  def end_game
    board_rendered
    if @human_cruiser.sunk? && @human_submarine.sunk?
        puts "I win. That was too easy. Where'd you learn those lame skills?"
        restart_game
    else @ai_cruiser.sunk? && @ai_submarine.sunk?
        puts "It looks like you got lucky and found a way to win."
        restart_game
    end
  end
end
