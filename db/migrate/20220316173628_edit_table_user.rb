class EditTableUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :ronin_address, :string
  end
end
