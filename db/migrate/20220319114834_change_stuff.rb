class ChangeStuff < ActiveRecord::Migration[6.1]
  def change

    drop_table :ronin_addresses

    add_column :teams, :ronin_address, :string

  end
end
