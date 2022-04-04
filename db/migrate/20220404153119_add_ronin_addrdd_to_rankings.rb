class AddRoninAddrddToRankings < ActiveRecord::Migration[6.1]
  def change

    add_column :rankings, :ronin_address, :string

  end
end
