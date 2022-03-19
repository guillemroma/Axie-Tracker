class RemoveReferenceFromConstruction < ActiveRecord::Migration[6.1]
  def change
    drop_table :constructions

    add_column :axies, :hp, :integer
    add_column :axies, :morale, :integer
    add_column :axies, :speed, :integer
    add_column :axies, :skill, :integer
    add_column :axies, :eyes, :string
    add_column :axies, :ears, :string
    add_column :axies, :back, :string
    add_column :axies, :mouth, :string
    add_column :axies, :horn, :string
    add_column :axies, :tail, :string
    add_column :axies, :image, :string


    add_column :teams, :mmr, :integer
    add_column :teams, :rank, :integer
    add_column :teams, :current_slp, :integer
    add_column :teams, :total_slp, :integer
    add_column :teams, :last_claim, :integer
    add_column :teams, :next_claim, :integer


    remove_column :axies, :breed

  end
end
