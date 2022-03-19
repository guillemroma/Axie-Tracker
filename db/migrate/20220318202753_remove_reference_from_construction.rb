class RemoveReferenceFromConstruction < ActiveRecord::Migration[6.1]
  def change
    drop_table :constructions

    add_column :pets, :hp, :integer
    add_column :pets, :morale, :integer
    add_column :pets, :speed, :integer
    add_column :pets, :skill, :integer
    add_column :pets, :eyes, :string
    add_column :pets, :ears, :string
    add_column :pets, :back, :string
    add_column :pets, :mouth, :string
    add_column :pets, :horn, :string
    add_column :pets, :tail, :string
    add_column :pets, :image, :string


    add_column :teams, :mmr, :integer
    add_column :teams, :rank, :integer
    add_column :teams, :current_slp, :integer
    add_column :teams, :total_slp, :integer
    add_column :teams, :last_claim, :integer
    add_column :teams, :next_claim, :integer


    remove_column :pets, :breed

  end
end
