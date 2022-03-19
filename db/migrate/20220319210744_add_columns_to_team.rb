class AddColumnsToTeam < ActiveRecord::Migration[6.1]
  def change

    add_column :teams, :scholar_name, :string
    add_column :teams, :win_rate, :integer

  end
end
