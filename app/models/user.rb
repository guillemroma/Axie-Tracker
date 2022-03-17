class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :teams, dependent: :destroy
  has_many :ronin_addresses, dependent: :destroy
  has_many :axies, through: :teams, dependent: :destroy
  has_many :favorites, dependent: :destroy

end
