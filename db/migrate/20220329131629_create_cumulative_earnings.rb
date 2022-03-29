class CreateCumulativeEarnings < ActiveRecord::Migration[6.1]
  def change
    create_table :cumulative_earnings do |t|
      t.references :team, null: false, foreign_key: true
      t.integer :total_slp
      t.date :date

      t.timestamps
    end
  end
end
