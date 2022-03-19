class ReplaceClassColumnAxie < ActiveRecord::Migration[6.1]
  def change

    remove_column :axies, :class
    add_column :axies, :axie_class, :string

  end
end
