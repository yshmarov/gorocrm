class Charge < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :subscription
  
  store :metadata, accessors: [:period_start, :period_end,
    :plan_name, :plan_amount, :plan_currency, :plan_interval, :plan_conditions]

end