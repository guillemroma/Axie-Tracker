class CreateDailyEarnings < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_earnings do |t|
      t.references :team, null: false, foreign_key: true
      t.integer :daily_slp
      t.date :date


      t.timestamps
    end
  end
end
