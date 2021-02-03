class Client < ApplicationRecord
  acts_as_tenant(:tenant)

  validates :email, presence: true
end
