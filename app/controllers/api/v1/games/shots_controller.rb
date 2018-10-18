module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = Game.find(params[:game_id])
          api = request.headers["X-API-Key"]
          if api == game.player_1_api_key || api == game.player_2_api_key
            render TurnProcessor.new(game, params[:shot][:target], request.headers["X-API-Key"]).message
          else
            render json: game, status: 401, message: 'Unauthorized'
          end
        end
      end
    end
  end
end
