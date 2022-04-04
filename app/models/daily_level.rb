class DailyLevel < ApplicationRecord

  validates_uniqueness_of :date, :scope => [:ronin_address]

end
