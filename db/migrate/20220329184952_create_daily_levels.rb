class CreateDailyLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_levels do |t|
      t.references :team, null: false, foreign_key: true
      t.integer :mmr
      t.date :date

      t.timestamps
    end
  end
end
