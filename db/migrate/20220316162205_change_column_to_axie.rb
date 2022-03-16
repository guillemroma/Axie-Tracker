class ChangeColumnToAxie < ActiveRecord::Migration[6.1]
  def change

    remove_column :axies, :body_parts
    add_reference :axies, :body_parts, index: true

  end
end
