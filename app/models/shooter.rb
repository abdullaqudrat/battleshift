class Shooter
  def initialize(board:, target:)
    @board     = board
    @target    = target
    @message   = ""
    @health     = 5
  end

  def fire!
    if valid_shot?
      result = space.attack!
      @board.health -= 1
      if @board.health == 0
        result + " Game over."
      else
        result
      end
    else
      raise InvalidAttack.new("Invalid coordinates.")
    end
  end

  def self.fire!(board:, target:)
    new(board: board, target: target).fire!
  end

  private
    attr_reader :board, :target

    def space
      @space ||= board.locate_space(target)
    end

    def valid_shot?
      board.space_names.include?(target)
    end
end

class InvalidAttack < StandardError
  def initialize(msg = "Invalid attack.")
    super(msg)
  end
end
