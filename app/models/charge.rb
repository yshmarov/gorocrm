# == Schema Information
#
# Table name: charges
#
#  id              :bigint           not null, primary key
#  tenant_id       :bigint           not null
#  subscription_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  metadata        :text
#
class Charge < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :subscription

  store :metadata, accessors: [:period_start, :period_end,
    :plan_name, :plan_amount, :plan_currency, :plan_interval, :plan_conditions]
end
