class Tenant < ApplicationRecord
  
  validates :name, presence: true, uniqueness: true

  has_many :members
  has_many :users, through: :members

  def to_s
    name
  end
  
end
