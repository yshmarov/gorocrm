class Tenant < ApplicationRecord
  
  validates :name, presence: true, uniqueness: true
  validates :name, length: { in: 2..20 }

  has_many :members, dependent: :destroy
  has_many :users, through: :members

  def to_s
    name
  end

  extend FriendlyId
  friendly_id :name, use: :slugged
  
end
