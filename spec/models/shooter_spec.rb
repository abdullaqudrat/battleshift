require 'rails_helper'

describe 'validations' do
  it 'should exist' do
    board = Board.new(4)
    target = 'A1'
    shooter = Shooter.new(board: board, target: target)
    expect(shooter).to be_a(Shooter)
  end

end
