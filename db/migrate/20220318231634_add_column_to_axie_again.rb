class AddColumnToAxieAgain < ActiveRecord::Migration[6.1]
  def change

    add_column :axies, :axie_game_id, :integer


  end
end
