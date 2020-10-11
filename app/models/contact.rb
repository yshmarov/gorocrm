class Contact < ApplicationRecord
  #belongs_to :tenant
  acts_as_tenant(:tenant)
  
  validates :first_name, :last_name, :phone_number, :email, presence: true
  #validates_uniqueness_to_tenant :first_name, :last_name, :phone_number, :email
  #validates_uniqueness_of :phone_number, scope: :tenant_id

end
