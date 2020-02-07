class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
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

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship != nil
      @ship.hit
    end
    @fired_upon = true
  end

  def render(show_ship = false)
    return "X" if @fired_upon == true && @ship.sunk? == true
    return "M" if @fired_upon == true && empty? == true
    return "H" if empty? == false && @fired_upon == true
    return "S" if empty? == false && show_ship == true
    return "."
  end
end
