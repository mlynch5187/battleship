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
    (ship.length == coordinates.length) && (consecutive_placement?(ship, coordinates) == true)
  end
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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

    split_coordinates(coordinates)
    sort_coordinates
    compare_and_verify_coordinates
  end
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  def split_coordinates(coordinates)
    # Split Coordinates from pair into arrays
    coordinates.map do |coordinate|
      @splitted_coordinates << coordinate.split(//)
    end

    @splitted_coordinates.each do |coordinate_pair|
      @letters << coordinate_pair[0]
      @numbers << coordinate_pair[1]
    end
  end
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  def sort_coordinates
    @letter = @letters.sort[0]
    @number = @numbers.sort[0]

    @length.times do |length|
      @same_letters << @letter
    end
    @length.times do |length|
      @consecutive_letters << @letter
      @letter = @letter.next
    end
    @length.times do |length|
      @same_numbers << @number
    end
    @length.times do |length|
      @consecutive_numbers << @number
      @number = @number.next
    end
  end
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  def compare_and_verify_coordinates
    if (@letters == @consecutive_letters) || (@letters == @same_letters)
      @letters_verify = true
    end

    if (@numbers == @consecutive_numbers.sort) || (@numbers == @same_numbers)
       @numbers_verify = true
    end

    if (@letters == @consecutive_letters) == (@numbers == @consecutive_numbers.sort)
      return false
    else
      return @letters_verify == true && @numbers_verify == true
    end
  end
end
