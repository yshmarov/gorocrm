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
