class Payment < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :payable, polymorphic: true
  belongs_to :cash_account
  validates :amount, presence: true

  def to_s
    [payable_type, payable_id].join(" ")
  end

  monetize :amount, as: :amount_cents

  include PublicActivity::Model
  tracked owner: proc { |controller, model| controller.current_user }
  tracked tenant_id: proc { ActsAsTenant.current_tenant.id }

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

end
