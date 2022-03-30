class ChangeIntegerLimitInDailyRanking < ActiveRecord::Migration[6.1]
  def change
    change_column :daily_rankings, :rank, :integer, limit: 8
  end
end
