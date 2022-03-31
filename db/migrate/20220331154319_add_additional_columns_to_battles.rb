class AddAdditionalColumnsToBattles < ActiveRecord::Migration[6.1]
  def change

    add_column :battles, :old_mmr, :integer
    add_column :battles, :new_mmr, :integer

  end
end
