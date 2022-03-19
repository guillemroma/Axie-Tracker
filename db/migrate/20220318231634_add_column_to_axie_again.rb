class AddColumnToAxieAgain < ActiveRecord::Migration[6.1]
  def change

    add_column :pets, :axie_game_id, :integer


  end
end
