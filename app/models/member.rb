class Member < ApplicationRecord
  belongs_to :user
  belongs_to :tenant

  validates :tenant_id, presence: true
  validates_uniqueness_of :user_id, scope: :tenant_id

  acts_as_tenant(:tenant)
end
