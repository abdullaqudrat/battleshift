module Api
  module V1
    module Games
      class ShipsController < ApiController
        def create
          game = Game.find(params[:game_id])
          ship = Ship.new(params[:ship_size])
          player = PlayerSelector.new(request.headers["X-API-Key"], game)
          placer = ShipPlacer.new(board: player.assets[:board],
                                  ship: ship,
                                  start_space: params[:start_space],
                                  end_space: params[:end_space]
                                )
          placer.run
          game.save
          render json: game, message: placer.gen_message
        end
      end
    end
  end
end
