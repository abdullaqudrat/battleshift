class PlayerSelector

  def initialize(api_key, game)
    @api_key = api_key
    @game = game
    api_setter(api_key)
  end

  def assets
    player = {}
    if @api_key == @game.player_1_api_key
      player[:board] = @game.player_2_board
      player[:turns] = @game.player_1_turns
    elsif @api_key == @game.player_2_api_key
      player[:board] = @game.player_1_board
      player[:turns] = @game.player_2_turns
    else
      player[:message] = "Invalid Auth"
    end
    player
  end

  def api_setter(api_key)
    if api_key != @game.player_1_api_key && @game.player_2_api_key.nil?
      @game.player_2_api_key = api_key
    end
  end

end
