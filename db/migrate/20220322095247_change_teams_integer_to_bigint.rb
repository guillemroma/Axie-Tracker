class ChangeTeamsIntegerToBigint < ActiveRecord::Migration[6.1]
  def change

     change_column :teams, :mmr, :bigint
     change_column :teams, :rank, :bigint
     change_column :teams, :current_slp, :bigint
     change_column :teams, :total_slp, :bigint
     change_column :teams, :last_claim, :bigint
     change_column :teams, :next_claim, :bigint

  end
end
