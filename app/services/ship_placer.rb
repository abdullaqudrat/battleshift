class ShipPlacer
  def initialize(board:, ship:, start_space:, end_space:)
    @board       = board
    @ship        = ship
    @start_space = start_space
    @end_space   = end_space
  end

  def run
    if same_row?
      place_in_row
    elsif same_column?
      place_in_column
    else
      raise InvalidShipPlacement.new("Ship must be in either the same row or column.")
    end
  end

  def calculate_ship_count
    if @board.count == 5
      ship_count = 0
    else
      ship_count = 1
    end
  end

  def calculate_remaining_ship_size
    if @board.count == 3
      remaining_ship = 2
    elsif @board.count == 2
      remaining_ship = 3
    end
  end

  def gen_message
    if calculate_ship_count == 1
      message = "Successfully placed ship with a size of #{@ship.length}. You have #{calculate_ship_count} ship(s) to place with a size of #{calculate_remaining_ship_size}."
    else
      message = "Successfully placed ship with a size of #{@ship.length}. You have 0 ship(s) to place."
    end
  end

  private
  attr_reader :board, :ship,
    :start_space, :end_space

  def same_row?
    start_space[0] == end_space[0]
  end

  def same_column?
    start_space[1] == end_space[1]
  end

  def place_in_row
    row = start_space[0]
    range = start_space[1]..end_space[1]
    msg = "Ship size must be equal to the number of spaces you are trying to fill."
    raise InvalidShipPlacement unless range.count == ship.length
    range.each { |column| place_ship(row, column) }
  end

  def place_in_column
    column = start_space[1]
    range   = start_space[0]..end_space[0]
    raise InvalidShipPlacement unless range.count == ship.length
    range.each { |row| place_ship(row, column) }
  end

  def place_ship(row, column)
    coordinates = "#{row}#{column}"
    space = board.locate_space(coordinates)
    if space.occupied?
      raise InvalidShipPlacement.new("Attempting to place ship in a space that is already occupied.")
    else
      @board.count += 1
      space.occupy!(ship)
    end
  end
end

class InvalidShipPlacement < StandardError
  def initialize(msg = "Invalid ship placement")
    super
  end
end
