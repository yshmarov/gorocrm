# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  plan_id    :bigint           not null
#  tenant_id  :bigint           not null
#  ends_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Subscription < ApplicationRecord
  belongs_to :plan
  acts_as_tenant(:tenant)
  has_many :charges, dependent: :nullify

  validates :tenant_id, uniqueness: true
  validates :ends_at, presence: true

  def active?
    ends_at > Time.now
  end
end
