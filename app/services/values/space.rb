class Space
  attr_reader :coordinates, :status, :contents

  def initialize(coordinates)
    @coordinates = coordinates
    @contents    = nil
    @status      = "Not Attacked"
  end

  def attack!
    @status = if contents && not_attacked?
                contents.attack!
                if contents.is_sunk?
                  "Hit. Battleship sunk."
                else
                  "Hit"
                end
              else
                "Miss"
              end
  end

  def occupy!(ship)
    @contents = ship
  end

  def occupied?
    !!@contents
  end

  def not_attacked?
    status == "Not Attacked"
  end
end
