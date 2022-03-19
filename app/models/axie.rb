class Axie < ApplicationRecord
  belongs_to :team

  validates :axie_game_id, uniqueness: true

end
