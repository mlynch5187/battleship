class Ship
  attr_reader :name, :health, :length
  def initialize(name, health)
    @name = name
    @health = 3
    @length = 3
  end

  def sunk?
    if @health == 0
      true
    else
      false
    end
  end

  def hit
    @health -= 1
  end
end
