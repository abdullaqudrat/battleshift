module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = Game.find(params[:game_id])
          render TurnProcessor.new(game, params[:shot][:target], request.headers["X-API-Key"]).message
        end
      end
    end
  end
end
