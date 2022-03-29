class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :teams, dependent: :destroy

  has_many :followeds_as_followed, class_name: "Follower", foreign_key: :followed_id, dependent: :destroy
  has_many :followers_as_follower, class_name: "Follower", foreign_key: :follower_id, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { maximum: 13,
    too_long: "max 23 characters" }

end
