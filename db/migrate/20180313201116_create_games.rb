class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.text :player_1_board
      t.text :player_2_board
      t.string :winner
      t.integer :player_1_turns, default: 0
      t.integer :player_2_turns, default: 0
      t.integer :current_turn
      t.string :player_1_api_key
      t.string :player_2_api_key
      t.timestamps
    end
  end
end
