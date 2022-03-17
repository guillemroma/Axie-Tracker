class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change

    add_reference :users, :ronin_addresses, index: true

  end
end
