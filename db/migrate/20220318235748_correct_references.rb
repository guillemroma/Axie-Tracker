class CorrectReferences < ActiveRecord::Migration[6.1]
  def change

  remove_reference :team, :user
  remove_reference :axie, :team
  remove_reference :battle, :teams

  end
end
