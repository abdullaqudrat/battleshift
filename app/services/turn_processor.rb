class TurnProcessor
  def initialize(game, target, api_key)
    @game   = game
    @target = target
    @messages = []
    @api_key = api_key
  end

  def run!
    begin
      attack_opponent
      # ai_attack_back
      if @api_key == game.player_1_api_key
        game.current_turn = "player_2"
      else
        game.current_turn = "player_1"
      end
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target

  def player_selector
    player = {}
    if @api_key == game.player_1_api_key
      player[:board] = game.player_2_board
      player[:turns] = game.player_1_turns

    else
      player[:board] = game.player_1_board
      player[:turns] = game.player_2_turns
    end
    player
  end

  def attack_opponent
    result = Shooter.fire!(board: player_selector[:board], target: target)
    @messages << "Your shot resulted in a #{result}."
    player_selector[:turns] += 1
  end

  def ai_attack_back
    result = AiSpaceSelector.new(player.board).fire!
    @messages << "The computer's shot resulted in a #{result}."
    game.player_2_turns += 1
  end

  def player
    Player.new(game.player_1_board)
  end

  def opponent
    Player.new(game.player_2_board)
  end

end
