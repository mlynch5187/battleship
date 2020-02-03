class Ship
  attr_reader :name, :health, :length
  def initialize(name, health)
    @name = name
    @health = 3
    @length = 3
  end

end
