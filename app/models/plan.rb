class Plan < ApplicationRecord

  validates :name, :amount, :currency, :interval, :max_members, presence: true

  RESERVED_INTERVALS = %w(month year forever)
  INTERVALS = [:month, :year, :forever]
  validates :interval, inclusion: { in: RESERVED_INTERVALS, message: "%{value} is not available." }

  validates :amount, :numericality => {greater_than_or_equal_to: 0, less_than: 100000}
  validates :max_members, :numericality => {greater_than_or_equal_to: 1, less_than: 1000}

  has_many :subscriptions
  
	def interval_period
		if interval == "forever"
			100.years
		elsif interval == "month"
			1.month
		elsif interval == "year"
			1.year
		end
	end

  def to_s
    name
  end

end
