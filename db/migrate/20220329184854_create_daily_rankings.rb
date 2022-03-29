class CreateDailyRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_rankings do |t|
      t.references :team, null: false, foreign_key: true
      t.integer :rank
      t.date :date

      t.timestamps
    end
  end
end
