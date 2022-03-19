class ChangeColumnToAxie < ActiveRecord::Migration[6.1]
  def change

    remove_column :pets, :body_parts
    add_reference :pets, :body_parts, index: true

  end
end
