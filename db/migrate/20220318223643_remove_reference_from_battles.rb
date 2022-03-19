class RemoveReferenceFromBattles < ActiveRecord::Migration[6.1]
  def change

    remove_reference :battles, :axie, index: true
    add_reference :battles, :team, index: true

  end
end
