module Api
  module V1
    module Games
      class ShipsController < ApiController
        def create
          game = Game.find(params[:game_id])
          ship = Ship.new(params[:ship_size])
          if request.headers["X-API-Key"] == game.player_1_api_key
            player_board = game.player_1_board
          else
            player_board = game.player_2_board
          end
          placer = ShipPlacer.new(board: player_board,
                                  ship: ship,
                                  start_space: params[:start_space],
                                  end_space: params[:end_space])

          game.current_turn = 'player_1'

          placer.run

          if player_board.count == 5
            ship_count = 0
          else
            ship_count = 1
          end

          if player_board.count == 3
            remaining_ship = 2
          elsif player_board.count == 2
            remaining_ship = 3
          end
          if ship_count == 1
            message = "Successfully placed ship with a size of #{ship.length}. You have #{ship_count} ship(s) to place with a size of #{remaining_ship}."
          else
            message = "Successfully placed ship with a size of #{ship.length}. You have 0 ship(s) to place."
          end
          game.save
          render json: game, message: message
        end
      end
    end
  end
end
