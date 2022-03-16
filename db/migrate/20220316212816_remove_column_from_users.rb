class RemoveColumnFromUsers < ActiveRecord::Migration[6.1]
  def change

    remove_column :users, :ronin_address

  end
end
