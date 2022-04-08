class Team < ApplicationRecord

  belongs_to :user
  has_many :pets, dependent: :destroy, class_name:  "Pet"

  validates :ronin_address, presence: true
  validates :ronin_address, uniqueness: true

  validates :scholar_name, presence: true

end
