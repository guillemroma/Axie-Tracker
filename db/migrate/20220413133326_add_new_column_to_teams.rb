class AddNewColumnToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :manager_share, :float
  end
end
