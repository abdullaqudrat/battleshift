require 'rails_helper'

describe 'Space Model' do
  it '#attack! and hits' do
    ship = Ship.new(2)
    space = Space.new('A1')
    allow_any_instance_of(Space).to receive(:contents).and_return(ship)

    space.attack!

    expect(space.status).to eq("Hit")
  end
  it '#attack! and sinks' do
    ship = Ship.new(1)
    space = Space.new('A1')
    allow_any_instance_of(Space).to receive(:contents).and_return(ship)

    space.attack!

    expect(space.status).to eq("Hit. Battleship sunk.")
  end
  it '#attack! but misses' do
    space = Space.new('A1')

    space.attack!

    expect(space.status).to eq("Miss")
  end
end
