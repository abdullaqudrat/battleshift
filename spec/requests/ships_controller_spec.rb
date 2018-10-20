require 'rails_helper'

describe 'Ships Controller' do
    it 'and return messages' do
    player_1 = User.create!(name: "player_1", email: "hello@example.com", address: "1600 Pennsylvania Ave NW, Washington, DC 20500", password: '1234', api_key: 'evyiYMExhwCS15JmBM7dkRjq')
    player_2 = User.create!(name: "player_2", email: "opponent@example.com", address: "1600 Pennsylvania Ave NW, Washington, DC 20500", password: '1234', api_key: 'cezhzkVCEzUP1zzvubCGMWiF')
    game = Game.create(player_1_board: Board.new(4),
                       player_2_board: Board.new(4),
                       player_1_api_key: player_1.api_key,
                       player_2_api_key: player_2.api_key)
    headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => player_1.api_key}

    payload = {ship_size: 2, start_space: "B1", end_space: "B2"}.to_json

    post "/api/v1/games/#{game.id}/ships", params: payload, headers: headers

    game = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(game).to have_key(:player_1_board)
  end
end
