require 'spec_helper'
require './app/services/ship_placer'
require './app/services/values/board'
require './app/services/values/space'

describe ShipPlacer do
  let(:board) { Board.new(4) }
  let(:ship)  { double(length: 2) }
  subject     { ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2") }

  it "exists when provided a board and ship" do
    expect(subject).to be_a ShipPlacer
  end

  it 'calculates ship count' do
    expect(subject.calculate_ship_count).to eq(1)
  end
  it 'generates a message' do
    expect(subject.gen_message).to eq("Successfully placed ship with a size of 2. You have 1 ship(s) to place with a size of .")
  end

  it 'calculates max ship count' do
    new_board = Board.new(4)
    two_ship = Ship.new(2)
    three_ship = Ship.new(3)
    ship_placer_first = ShipPlacer.new(board: new_board, ship: three_ship, start_space: 'A1', end_space: 'A3')
    ship_placer_first.run
    ship_placer_second = ShipPlacer.new(board: new_board, ship: two_ship, start_space: 'B1', end_space: 'B2')
    ship_placer_second.run

    expect(ship_placer_second.calculate_ship_count).to eq(0)
    expect(ship_placer_second.gen_message).to eq("Successfully placed ship with a size of 2. You have 0 ship(s) to place.")
  end
  it 'calculates remaining ship count' do
    new_board = Board.new(4)
    two_ship = Ship.new(2)
    ship_placer_second = ShipPlacer.new(board: new_board, ship: two_ship, start_space: 'B1', end_space: 'B2')
    ship_placer_second.run

    expect(ship_placer_second.calculate_remaining_ship_size).to eq(3)
  end
  it 'calculates remaining ship count for big ships' do
    new_board = Board.new(4)
    two_ship = Ship.new(3)
    ship_placer_second = ShipPlacer.new(board: new_board, ship: two_ship, start_space: 'B1', end_space: 'B3')
    ship_placer_second.run

    expect(ship_placer_second.calculate_remaining_ship_size).to eq(2)
  end
  it "places the ship within a row with empty spaces" do
    a1 = board.locate_space("A1")
    a2 = board.locate_space("A2")
    a3 = board.locate_space("A3")
    b1 = board.locate_space("B1")

    expect(a1.contents).to be_nil
    expect(a2.contents).to be_nil
    expect(a3.contents).to be_nil
    expect(b1.contents).to be_nil

    subject.run

    expect(a1.contents).to eq(ship)
    expect(a2.contents).to eq(ship)
    expect(a3.contents).to be_nil
    expect(b1.contents).to be_nil
  end

  it "places the ship within a column with empty spaces" do
    a1 = board.locate_space("A1")
    b1 = board.locate_space("B1")

    neighbor_1 = board.locate_space("A2")
    neighbor_2 = board.locate_space("B2")

    expect(a1.contents).to be_nil
    expect(b1.contents).to be_nil
    expect(neighbor_1.contents).to be_nil
    expect(neighbor_2.contents).to be_nil

    ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B1").run

    expect(a1.contents).to eq(ship)
    expect(b1.contents).to eq(ship)
    expect(neighbor_1.contents).to be_nil
    expect(neighbor_2.contents).to be_nil
  end

  it "doesn't place the ship if it isn't within the same row or column" do
    expect {
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B2").run
    }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the space is occupied when placing in columns" do
    ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B1").run
    expect {
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B1").run
    }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the space is occupied when placing in rows" do
    ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2").run
    expect {
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2").run
    }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the ship is smaller than the supplied range in a row" do
    expect {
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A3").run
    }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the ship is smaller than the supplied range in a column" do
    expect {
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "C1").run
    }.to raise_error(InvalidShipPlacement)
  end
end
