class CashAccount < ApplicationRecord
  acts_as_tenant(:tenant)
  has_many :payments

  validates :name, presence: true, uniqueness: true

  include PublicActivity::Model
  tracked owner: proc { |controller, model| controller.current_user }
  tracked tenant_id: proc { ActsAsTenant.current_tenant.id }

  monetize :balance, as: :balance_cents

  def to_s
    name
  end

end
