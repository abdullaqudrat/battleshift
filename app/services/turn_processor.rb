class TurnProcessor
  attr_reader :message
  def initialize(game, target, api_key)
    @game   = game
    @target = target
    @message = {}
    @player = PlayerSelector.new(api_key, game)
    return self if invalid_turn
    run!
  end

  private

  attr_reader :game, :target

  def run!
    begin
      attack_opponent
      set_current_turn
      check_for_winner
    rescue InvalidAttack => e
      @message = {json: game, message: e.message, status: 400 }
    end
    self
  end

  def set_current_turn
    if @player.current_player_api == game.player_1_api_key
      game.current_turn = "player_2"
    else
      game.current_turn = "player_1"
    end
    game.save!
  end

  def check_for_winner
    if game.winner.nil?
      set_winner
    else
      @message = { json: game,
                   status: 400,
                   message: "Invalid move. Game over." }
    end
  end

  def invalid_turn
    if @player.current_player_api.nil?
      @message = { json: game,
                   status: 400,
                   message: "Invalid move. It's your opponent's turn"}
      true
    end
  end

  def set_winner
    if @player.assets[:board].health == 0
      game.winner = User.find_by(api_key: @player.api_key ).email
      game.save!
    end
  end

  def attack_opponent
    result = Shooter.fire!(board: @player.assets[:board], target: target)
    @message = {json: game, message: "Your shot resulted in a #{result}."}
    @player.assets[:turns] += 1
  end
end
