module Api
  module V1
    module Games
      class ShipsController < ApiController
        def create
          game = Game.find(params[:game_id])
          ship = Ship.new(params[:ship_size])
          placer = ShipPlacer.new(board: game.player_1_board,
                                  ship: ship,
                                  start_space: params[:start_space],
                                  end_space: params[:end_space])

          placer.run
          if game.player_1_board.count == 5
            ship_count = 0
          else
            ship_count = 1
          end

          if game.player_1_board.count == 3
            remaining_ship = 2
          elsif game.player_1_board.count == 2
            remaining_ship = 3
          end
          game.current_turn = 'challenger'
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
