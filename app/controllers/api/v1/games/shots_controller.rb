module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = Game.find(params[:game_id])
          player = PlayerSelector.new(request.headers["X-API-Key"], game)
          render TurnProcessor.new(game, params[:shot][:target], player).message
        end
      end
    end
  end
end
