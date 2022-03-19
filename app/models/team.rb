class Team < ApplicationRecord


  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :battles, dependent: :destroy
  has_many :pets, dependent: :destroy, class_name:  "Pet"


  validates :mmr, uniqueness: true
  validates :rank, uniqueness: true
  validates :current_slp, uniqueness: true
  validates :total_slp, uniqueness: true
  validates :last_claim, uniqueness: true
  validates :next_claim, uniqueness: true
  validates :ronin_address, uniqueness: true

end
