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
    if ship.length == coordinates.length
      true
    else
      false
    end
  end

  def split_consecutive_letters(coordinates)
    split_array = []
    coordinates.each do |coordinate|
      split_array << coordinate.split(//)
    end
    split_array
    letter_array = []
      split_array.each do |element|
        letter_array << element[0]
      end
    letter_array
  end

  def split_consecutive_numbers(coordinates)
    split_array = []
    coordinates.each do |coordinate|
      split_array << coordinate.split(//)
    end
    split_array
    number_array = []
      split_array.each do |element|
        number_array << element[1]
      end
    number_array
  end
end
