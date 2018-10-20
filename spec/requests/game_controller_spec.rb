require 'rails_helper'


describe 'Game' do
  context 'create a game' do
    it 'returns a game ' do
      player_1 = User.create!(name: "player_1", email: "hello@example.com", address: "1600 Pennsylvania Ave NW, Washington, DC 20500", password: '1234', api_key: 'evyiYMExhwCS15JmBM7dkRjq')
      player_2 = User.create!(name: "player_2", email: "opponent@example.com", address: "1600 Pennsylvania Ave NW, Washington, DC 20500", password: '1234', api_key: 'cezhzkVCEzUP1zzvubCGMWiF')

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => player_1.api_key}

      payload =

      post '/api/v1/games', params: { opponent_email: player_2.email }.to_json, headers: headers
      game = JSON.parse(response.body, symbolize_names: true)

      expect(game).to have_key(:player_1_board)
      expect(game).to have_key(:current_turn)
    end
  end
end
