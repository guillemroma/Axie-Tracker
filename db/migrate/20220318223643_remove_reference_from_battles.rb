class RemoveReferenceFromBattles < ActiveRecord::Migration[6.1]
  def change

    remove_reference :battles, :pet, index: true
    add_reference :battles, :team, index: true

  end
end
