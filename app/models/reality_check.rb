class RealityCheck < ApplicationRecord
	belongs_to :user
	  scope :today, -> { where "created_at >= ? ", DateTime.current.beginning_of_day + 4.hours }

end
