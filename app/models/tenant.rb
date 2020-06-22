class Tenant < ApplicationRecord
  
  validates :name, presence: true, uniqueness: true
  validates :name, length: { in: 2..20 }

  has_many :members
  has_many :users, through: :members

  def to_s
    name
  end
  
end
