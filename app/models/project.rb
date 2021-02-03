class Project < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :client
  validates :client, :payment_type, :name, presence: true

  monetize :price, as: :price_cents

  PAYMENT_TYPES = [:hourly, :fixed]
  def self.payment_types
    PAYMENT_TYPES.map { |payment_type| [payment_type, payment_type] }
  end

  def to_s
    name
  end

end
