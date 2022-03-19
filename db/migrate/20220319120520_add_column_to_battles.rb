class AddColumnToBattles < ActiveRecord::Migration[6.1]
  def change

    add_column :battles, :battle_uuid, :integer

  end
end
