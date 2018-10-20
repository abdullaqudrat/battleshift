require 'rails_helper'

describe 'Ship' do
  it '#place' do
    ship = Ship.new(2)
    ship.place('a1', 'a2')
    expect(ship.start_space).to eq('a1')
    expect(ship.end_space).to eq('a2')
  end
  it '#attack!' do
    ship = Ship.new(2)
    ship.attack!
    expect(ship.damage).to eq(1)
    expect(ship.is_sunk?).to eq(false)
  end
  it '#attack!' do
    ship = Ship.new(2)
    ship.attack!
    ship.attack!
    expect(ship.is_sunk?).to eq(true)
  end
end
