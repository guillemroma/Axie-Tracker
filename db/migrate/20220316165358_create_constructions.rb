class CreateConstructions < ActiveRecord::Migration[6.1]
  def change
    create_table :constructions do |t|
      t.references :axie, null: false, foreign_key: true
      t.integer :health
      t.integer :speed
      t.integer :morale
      t.integer :skill
      t.string :back
      t.string :horn
      t.string :tail
      t.string :mouth
      t.string :ears
      t.string :eyes

      t.timestamps
    end
  end
end
