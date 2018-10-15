module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = Game.find(params[:game_id])
          if game.current_turn == "player_1" && request.headers["X-API-Key"] == game.player_1_api_key
            turn_processor = TurnProcessor.new(game, params[:shot][:target], request.headers["X-API-Key"])
            turn_processor.run!
            if turn_processor.message.include?("Invalid")
              render json: game, message: turn_processor.message, status: 400
            else
              render json: game, message: turn_processor.message
            end
          elsif game.current_turn == "player_2" && request.headers["X-API-Key"] != game.player_1_api_key
            turn_processor = TurnProcessor.new(game, params[:shot][:target], request.headers["X-API-Key"])
            turn_processor.run!
            if turn_processor.message.include?("Invalid")
              render json: game, message: turn_processor.message, status: 400
            else
              render json: game, message: turn_processor.message
            end
          else
            render json: game, status: 400, message: "Invalid move. It's your opponent's turn"
          end
        end
      end
    end
  end
end
