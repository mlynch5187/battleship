class Board
  attr_reader :cells
  def initialize()
    @cells = {}
    @cells["A1"] = Cell.new("A1")
    @cells["A2"] = Cell.new("A2")
    @cells["A3"] = Cell.new("A3")
    @cells["A4"] = Cell.new("A4")
    @cells["B1"] = Cell.new("B1")
    @cells["B2"] = Cell.new("B2")
    @cells["B3"] = Cell.new("B3")
    @cells["B4"] = Cell.new("B4")
    @cells["C1"] = Cell.new("C1")
    @cells["C2"] = Cell.new("C2")
    @cells["C3"] = Cell.new("C3")
    @cells["C4"] = Cell.new("C4")
    @cells["D1"] = Cell.new("D1")
    @cells["D2"] = Cell.new("D2")
    @cells["D3"] = Cell.new("D3")
    @cells["D4"] = Cell.new("D4")
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    open = coordinates.all? do |coordinate|
      @cells[coordinate].empty?
    end

    if open
      (ship.length == coordinates.length) && (consecutive_placement?(ship, coordinates) == true)
    else
      false
    end
  end

 def consecutive_placement?(ship, coordinates)
   @length = ship.length
   @letters = []
   @numbers = []
   @consecutive_letters = []
   @same_letters = []
   @consecutive_numbers = []
   @same_numbers = []
   @letters_verify = false
   @numbers_verify = false
   @splitted_coordinates = []

   splitted_coordinates = split_coordinates(coordinates)
   organized_coordinates = organize_split_coordinates(splitted_coordinates)
   compare_and_verify_coordinates(organized_coordinates)
 end

 def split_coordinates(coordinates)
   coordinates.map do |coordinate|
     coordinate.split(//)
   end
 end

 def organize_split_coordinates(split_coordinates)
   @letters = []
   @numbers = []
   split_coordinates.each do |coordinate_pair|
     @letters << coordinate_pair[0]
     @numbers << coordinate_pair[1]
   end
   [@letters, @numbers]
 end

 def compare_and_verify_coordinates(organized_coordinates)
   @orginal_letters = organized_coordinates[0]
   @orginal_numbers = organized_coordinates[1]
   @letter = @orginal_letters.sort[0]
   @number = @orginal_numbers.sort[0]
   @length = @orginal_letters.length
   @same_letters = []
   @same_numbers = []
   @consecutive_numbers = []
   @same_numbers = []

   create_same_coordinate_pairs
   create_consecutive_coordinate_pairs
   letters_verify?
   numbers_verify?
   not_diagonal?
 end

 def create_same_coordinate_pairs
   @length.times do |length|
     @same_letters << @letter
     @same_numbers << @number
   end
   [@same_letters, @same_numbers]
 end

 def create_consecutive_coordinate_pairs
   @length.times do |length|
     @consecutive_letters << @letter
     @letter = @letter.next
     @consecutive_numbers << @number
     @number = @number.next
   end
   [@consecutive_letters, @consecutive_numbers]
 end

  def letters_verify?
    if (@letters == @consecutive_letters) || (@letters == @same_letters)
      @letters_verify = true
    end
  end

  def numbers_verify?
    if (@numbers == @consecutive_numbers.sort) || (@numbers == @same_numbers)
       @numbers_verify = true
    end
  end

  def not_diagonal?
    if (@letters == @consecutive_letters) && (@numbers == @consecutive_numbers.sort)
      return false
    else
      return @letters_verify == true && @numbers_verify == true
    end
  end

 def place(ship, coordinates)
   if valid_placement?(ship, coordinates)
     coordinates.each do |coordinate|
       @cells[coordinate].place_ship(ship)
     end
   end
 end

 def render(show_ship = false)
   "  1 2 3 4  \n" +
    "A " + @cells["A1"].render(show_ship) + " " + @cells["A2"].render(show_ship) + " " + @cells["A3"].render(show_ship) + " " + @cells["A4"].render(show_ship) + "\n" +
    "B " + @cells["B1"].render(show_ship) + " " + @cells["B2"].render(show_ship) + " " + @cells["B3"].render(show_ship) + " " + @cells["B4"].render(show_ship) + "\n" +
    "C " + @cells["C1"].render(show_ship) + " " + @cells["C2"].render(show_ship) + " " + @cells["C3"].render(show_ship)+ " " + @cells["C4"].render(show_ship) + "\n" +
    "D " + @cells["D1"].render(show_ship) + " " + @cells["D2"].render(show_ship) + " " + @cells["D3"].render(show_ship) + " " + @cells["D4"].render(show_ship) + "\n"
 end
end
