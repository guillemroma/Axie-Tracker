class CreateRoninAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :ronin_addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
