class RemoveReferenceFromUser < ActiveRecord::Migration[6.1]
  def change

    remove_reference :users, :ronin_addresses, index: true

  end
end
