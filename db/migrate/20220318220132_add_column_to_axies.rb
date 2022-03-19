class AddColumnToAxies < ActiveRecord::Migration[6.1]
  def change

      add_column :axies, :class, :string

    end
end
