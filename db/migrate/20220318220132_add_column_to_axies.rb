class AddColumnToAxies < ActiveRecord::Migration[6.1]
  def change

      add_column :pets, :class, :string

    end
end
