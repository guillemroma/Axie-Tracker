class CreateAxies < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :breed
      t.string :body_parts
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
