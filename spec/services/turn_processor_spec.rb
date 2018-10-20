require 'rails_helper'


describe 'TurnProcessor Selector' do
  before(:each) do
    @player_1_board = Board.new(4)
    @player_2_board = Board.new(4)
    @player_1_api   = '12345'
    @player_2_api   = '67891'
    @game = Game.new(player_1_board:  @player_1_board,
                    player_2_board:   @player_2_board,
                    player_1_api_key: @player_1_api,
                    player_2_api_key: @player_2_api)
    end
  it 'should process turns' do
    processor = TurnProcessor.new(@game, 'A1', @player_1_api)
    expect(processor.message[:message]).to eq("Your shot resulted in a Miss.")
  end
  it 'should not process invalid coordinates' do
    @game.current_turn = 'player_2'
    processor = TurnProcessor.new(@game, 'z1', @player_2_api)
    expect(processor.message[:message]).to eq("Invalid coordinates.")
  end
  it 'should not process invalid turns' do
    @game.current_turn = 'player_2'
    allow_any_instance_of(PlayerSelector).to receive(:current_player_api).and_return(nil)

    processor = TurnProcessor.new(@game, 'z1', @player_2_api)
    expect(processor.message[:message]).to eq("Invalid move. It's your opponent's turn")
  end
end
