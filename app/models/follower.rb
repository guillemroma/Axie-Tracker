class Follower < ApplicationRecord
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"

  validate :doesnt_follow_self

  validates_uniqueness_of :followed_id, :scope => [:follower_id]

  private
  
  def doesnt_follow_self
    errors.add(:base, 'You can\'t follow yourself') if followed_id == follower_id
  end

end
