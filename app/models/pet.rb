class Pet < ApplicationRecord
  belongs_to :team, class_name: "Team", foreign_key: "team_id"

  validates :axie_game_id, uniqueness: true

end
