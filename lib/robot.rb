class Robot

  @@robots = []

  attr_accessor :equipped_weapon
  attr_reader :position, :items, :health, :shield

  CAPACITY = 250 # Best implementation of capacity? YES!
  MAX_HEALTH = 100
  MAX_SHIELDS = 50

  def initialize
    @position = [0, 0]
    @items = []
    @health = MAX_HEALTH
    @shield = MAX_SHIELDS
    @@robots << self
    end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)
    # Should the weapon goes in the itens? Or just equip and never see its weigth?
    if can_carry?(item)
      self.equipped_weapon = item if item.is_a?(Weapon)
      item.feed(self) if health <= 80 && item.is_a?(BoxOfBolts)
      @items << item
      end
  end

  def items_weight
    @items.inject(0) do |sum_weight, item|
      sum_weight + item.weight
    end
  end

  def can_carry?(item)
    items_weight + item.weight <= CAPACITY
  end

  def wound(damage_value)
    @health = [0, @health - damage_value].max
  end

  def heal(health_value)
    @health = [MAX_HEALTH, @health + health_value].min
  end

  def dead?
    health <= 0
  end

  def heal!(health_value)
    raise(Exceptions::RobotAlreadyDeadError, "This robot is already dead!") if dead?
    heal(health_value)
  end

  def attack(foe)
    if equipped_weapon && in_range?(foe, equipped_weapon)
      equipped_weapon.hit(foe)
      self.equipped_weapon = nil
    elsif is_close?(foe)
      foe.wound(5)
    end
  end

  def attack!(foe)
    raise(Exceptions::UnattackableEnemy, "The enemy is not a robot") unless foe.is_a?(Robot)
    attack(foe)
  end

  def is_close?(other)
    VectorAlgebra.norm(other.position) <= 1
  end

  def in_range?(other, item)
    VectorAlgebra.norm(other.position) <= item.range
  end

end
