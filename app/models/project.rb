class Project < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :client
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :tasks, dependent: :restrict_with_error, counter_cache: true

  validates :client, :payment_type, :name, presence: true

  monetize :price, as: :price_cents

  PAYMENT_TYPES = [:hourly, :fixed]
  def self.payment_types
    PAYMENT_TYPES.map { |payment_type| [payment_type, payment_type] }
  end

  STATUSES = %w[active archived]
  validates :status, inclusion: {in: STATUSES, message: "%{value} is not available."}
  def self.statuses
    STATUSES.map { |status| [status, status] }
  end

  def to_s
    name
  end

  include PublicActivity::Model
  tracked owner: proc { |controller, model| controller.current_user }
  tracked tenant_id: proc { ActsAsTenant.current_tenant.id }

end
