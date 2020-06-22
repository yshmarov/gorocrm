class Member < ApplicationRecord
  belongs_to :user
  #belongs_to :tenant #acts_as_tenant includes this

  validates :tenant_id, presence: true
  validates_uniqueness_of :user_id, scope: :tenant_id

  acts_as_tenant(:tenant)
  #validates_uniqueness_to_tenant :user_id 

end
