class Member < ApplicationRecord
  belongs_to :user, counter_cache: true
  #User.find_each { |user| User.reset_counters(user.id, :members) }  
  #belongs_to :tenant #acts_as_tenant includes this
  acts_as_tenant(:tenant) #counter_cache is currently not supported for acts_as_tenant. Pull request https://github.com/ErwinM/acts_as_tenant/pull/225
  #validates_uniqueness_to_tenant :user_id 

  validates :tenant_id, presence: true
  validates_uniqueness_of :user_id, scope: :tenant_id

end
