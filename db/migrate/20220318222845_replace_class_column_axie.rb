class ReplaceClassColumnAxie < ActiveRecord::Migration[6.1]
  def change

    remove_column :pets, :class
    add_column :pets, :axie_class, :string

  end
end
