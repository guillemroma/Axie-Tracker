class Battle < ApplicationRecord
  belongs_to :team

  validates :battle_uuid, uniqueness: true
  validates :result, :inclusion => { :in => ["won", "lost"]}

end
