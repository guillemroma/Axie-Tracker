class CreateRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :rankings do |t|
      t.integer :rank
      t.string :scholar_name
      t.integer :mmr

      t.timestamps
    end
  end
end
