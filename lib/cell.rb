class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    if @ship == nil || false
      true
    else
      false
    end
  end

  def place_ship(ship_name)
    @ship = ship_name
  end
end
