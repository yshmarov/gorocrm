class Charge < ApplicationRecord
  belongs_to :tenant
  belongs_to :subscription
  
  validates :amount, presence: true

end
