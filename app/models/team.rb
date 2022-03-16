class Team < ApplicationRecord
  belongs_to :user
  has_many :axies, dependent: :destroy


end
