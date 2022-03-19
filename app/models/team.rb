class Team < ApplicationRecord


  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :battles, dependent: :destroy
  has_many :pets, dependent: :destroy, class_name:  "Pet"

  validates :ronin_address, presence: true
  validates :scholar_name, presence: true

end
