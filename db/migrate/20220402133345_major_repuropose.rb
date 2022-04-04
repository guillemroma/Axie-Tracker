class MajorRepuropose < ActiveRecord::Migration[6.1]
  def change

    drop_table :cumulative_earnings

    remove_reference :daily_earnings, :team, index: true
    remove_reference :daily_levels, :team, index: true
    remove_reference :daily_rankings, :team, index: true
    remove_reference :battles, :team, index: true

    add_column :daily_earnings, :ronin_address, :string
    add_column :daily_levels, :ronin_address, :string
    add_column :daily_rankings, :ronin_address, :string
    add_column :battles, :ronin_address, :string

  end
end
