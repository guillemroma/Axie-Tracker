class UpdateColumnToAxie < ActiveRecord::Migration[6.1]
  def change
    remove_reference :axies, :body_parts, index: true
    drop_table :body_parts
  end
end
