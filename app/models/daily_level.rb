class DailyLevel < ApplicationRecord
  belongs_to :team

  validates_uniqueness_of :date, :scope => [:team_id]
  validate :greater_than_15_days

  def greater_than_15_days
    errors.add(:date, "can't be in the past") if date < (Date.today - 15)
  end
  
end
