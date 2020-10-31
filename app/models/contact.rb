class Contact < ApplicationRecord

  acts_as_tenant(:tenant)
  
  validates :first_name, :last_name, :phone_number, :email, presence: true

end
