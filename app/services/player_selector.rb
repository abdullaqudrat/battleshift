class PlayerSelector
  attr_reader :api_key

  def initialize(api_key, game)
    @api_key = api_key
    @game = game
  end

  def assets
    player = {}
    if @api_key == @game.player_1_api_key

      player = { board: @game.player_2_board,
                 turns: @game.player_1_turns }
    elsif @api_key == @game.player_2_api_key
      player = { board: @game.player_1_board,
                 turns: @game.player_2_turns }
    else
      player = { message:  "Invalid Auth" }
    end
  end

  def api_setter(api_key)
    if api_key != @game.player_1_api_key && @game.player_2_api_key.nil?
      @game.player_2_api_key = api_key
    end
  end

  def current_player_api
    if @game.current_turn == "player_1" && @api_key == @game.player_1_api_key
      @game.player_1_api_key
    elsif @game.current_turn == "player_2" && @api_key == @game.player_2_api_key
      @game.player_2_api_key
    else
      nil
    end
  end

  def opponent_health
    if @game.current_turn == "player_1"
      @game.player_2_board.health
    elsif @game.current_turn == "player_2"
      @game.player_1_board.health
    end
  end

  def valid_player?
    @api_key == @game.player_1_api_key || @api_key == @game.player_2_api_key
  end
end
