class Robot

  attr_accessor :equipped_weapon
  attr_reader :position, :items, :health

  CAPACITY = 250 # Best implementation of capacity?

  def initialize
    @position = [0, 0]
    @items = []
    @health = 100
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
    if can_carry?(item)
      @items << item
      self.equipped_weapon = item if item.is_a?(Weapon)
      true
    else
      false
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
    if @health - damage_value <= 0
      @health = 0
    else
      @health -= damage_value
    end
  end

  def heal(health_value)
    if @health + health_value >= 100
      @health = 100
    else
      @health += health_value
    end
  end

  def dead?
    health <= 0
  end

  def heal!(health_value)
    raise(Exceptions::RobotAlreadyDeadError, "This robot is already dead!") if dead?
    heal(health_value)
  end

  def attack(foe)
    if equipped_weapon
      equipped_weapon.hit(foe)
    else
      foe.wound(5)
    end
  end

  def attack!(foe)
    raise(Exceptions::UnattackableEnemy, "The enemy is not a robot") unless foe.is_a?(Robot)
    attack(foe)
  end

end
