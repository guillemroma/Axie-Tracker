class Team < ApplicationRecord
  belongs_to :user
  has_many :pets, dependent: :destroy, class_name:  "Pet"

  validate :ronin_address_valid?
  validates :manager_share, numericality: true
  validates :manager_share, inclusion: 0.00..100.00

  validates :ronin_address, presence: true
  validates :ronin_address, uniqueness: true

  validates :scholar_name, presence: true

  private

  def ronin_address_valid?
    unless ronin_address.starts_with?("0x")
      errors.add(:ronin_address, "must be a valid address")
    end
  end
end
