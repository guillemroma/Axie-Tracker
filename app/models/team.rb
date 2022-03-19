class Team < ApplicationRecord
  belongs_to :user

  has_many :favorites
  has_many :battles, dependent: :destroy
  has_many :axies, dependent: :destroy




end
