class CreateBattles < ActiveRecord::Migration[6.1]
  def change
    create_table :battles do |t|
      t.references :axie, null: false, foreign_key: true
      t.string :result

      t.timestamps
    end
  end
end
