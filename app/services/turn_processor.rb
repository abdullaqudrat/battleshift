class TurnProcessor
  attr_reader :message
  def initialize(game, target, player)
    @game   = game
    @target = target
    @message = {}
    @api_key = player.current_player_api
    @player_selector = PlayerSelector.new(@api_key, game).assets
    return self if invalid_turn
    run!
    winner?
  end

  def run!
    begin
      attack_opponent
      if @api_key == game.player_1_api_key
        game.current_turn = "player_2"
      else
        game.current_turn = "player_1"
      end
      game.save!
    rescue InvalidAttack => e
      @message = {json: game, message: e.message, status: 400 }
    end
    self
  end

  def winner?
    if game.winner.nil?
      set_winner
    else
      @message = { json: game,
                   status: 400,
                   message: "Invalid move. Game over." }
    end
  end

  def invalid_turn
    if @api_key.nil?
      @message = { json: game,
                   status: 400,
                   message: "Invalid move. It's your opponent's turn"}
      true
    end
  end

  def set_winner
    if @player_selector[:board].health == 0
      game.winner = User.find_by(api_key: @api_key ).email
      game.save!
    end
  end

  private

  attr_reader :game, :target

  def attack_opponent
    result = Shooter.fire!(board: @player_selector[:board], target: target)
    @message = {json: game, message: "Your shot resulted in a #{result}."}
    @player_selector[:turns] += 1
  end
end
