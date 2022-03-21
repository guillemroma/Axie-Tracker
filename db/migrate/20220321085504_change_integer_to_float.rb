class ChangeIntegerToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :teams, :win_rate, :float
  end
end
