class Battle < ApplicationRecord

  validates :battle_uuid, uniqueness: true
  validates :result, :inclusion => { :in => ["won", "lost"]}

end
