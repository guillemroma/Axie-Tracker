class Team < ApplicationRecord

  belongs_to :user

  has_many :battles, dependent: :destroy
  has_many :pets, dependent: :destroy, class_name:  "Pet"
  has_many :daily_earnings, dependent: :destroy
  has_many :cumulative_earnings, dependent: :destroy
  has_many :daily_earnings, dependent: :destroy
  has_many :daily_levels, dependent: :destroy

  validates :ronin_address, presence: true
  validates :ronin_address, uniqueness: true

  validates :scholar_name, presence: true


end
