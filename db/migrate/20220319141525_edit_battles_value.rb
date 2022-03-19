class EditBattlesValue < ActiveRecord::Migration[6.1]
  def change

    change_column :battles, :battle_uuid, :string

  end
end
