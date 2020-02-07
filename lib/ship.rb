class Ship
  attr_reader :name, :length, :health
  def initialize(name, health)
    @name = name
    @health = health
    @length = health
    @sunk = false
  end

  def sunk?
    @sunk
  end

  def hit
    @health -= 1
    if @health == 0
      @sunk = true
    end
  end
end
