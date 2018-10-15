module Api
  module V1
    class GamesController < ActionController::API
      def show
        game = Game.find_by(id: params[:id])
        render status: 400 unless game
        render json: game if game
      end

      def create
        board_1 = Board.new(4)
        board_2 = Board.new(4)
        game = Game.create(player_1_board: board_1,
                        player_2_board: board_2,
                        player_1_api_key: request.headers["X-API-Key"])
        render json: game if game
      end
    end
  end
end
