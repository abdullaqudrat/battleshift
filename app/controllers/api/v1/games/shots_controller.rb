module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = Game.find(params[:game_id])
          player = PlayerSelector.new(request.headers["X-API-Key"], game)

          render json: game, status: 400, message: "Invalid move. Game over." and return unless game.winner.nil?
          render json: game, status: 400, message: "Invalid move. It's your opponent's turn" and return if player.current_player_api.nil?

          turn_processor = TurnProcessor.new(game, params[:shot][:target], player.current_player_api)
          turn_processor.run!
          turn_processor.winner?

          render turn_processor.message
        end
      end
    end
  end
end
