class CumulativeEarning < ApplicationRecord
  belongs_to :team

  validates_uniqueness_of :date, :scope => [:team_id]
  
end
