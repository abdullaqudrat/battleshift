require 'rails_helper'

describe 'Player Selector' do
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
  it 'should return assets for player_1' do
    selector = PlayerSelector.new(@player_1_api, @game)

    expected = { board: @game.player_2_board,
                 turns: @game.player_1_turns }

    expect(selector.assets).to eq(expected)
  end
  it 'should return assets for player_2' do
    selector = PlayerSelector.new(@player_2_api, @game)

    expected = { board: @game.player_1_board,
                 turns: @game.player_2_turns }

    expect(selector.assets).to eq(expected)
  end
  it 'should return invalid_auth' do
    selector = PlayerSelector.new('abcd', @game)

    expect(selector.assets).to eq({message: 'Invalid Auth'})
  end
  it 'should return current_player as player 2'do
    @game.current_turn = "player_2"
    selector = PlayerSelector.new(@player_2_api, @game)

    expect(selector.current_player_api).to eq(@player_2_api)
  end
  it 'should return current_player as player_1' do
    @game.current_turn = "player_1"
    selector = PlayerSelector.new(@player_1_api, @game)

    expect(selector.current_player_api).to eq(@player_1_api)
  end
  it 'should return player 1 health'do
    @game.current_turn = "player_2"
    selector = PlayerSelector.new(@player_2_api, @game)

    expect(selector.opponent_health).to eq(5)
  end
  it 'should return current_player as player_1' do
    @game.current_turn = "player_1"
    selector = PlayerSelector.new(@player_1_api, @game)

    expect(selector.opponent_health).to eq(5)
  end
  it 'should return invalid player' do
    selector = PlayerSelector.new("abcde", @game)

    expect(selector.valid_player?).to eq(false)
  end
end
