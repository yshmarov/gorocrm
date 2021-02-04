class Member < ApplicationRecord
  belongs_to :user, counter_cache: true
  acts_as_tenant :tenant, counter_cache: true
  has_many :tasks, dependent: :restrict_with_error
  has_many :payments, as: :payable, dependent: :restrict_with_error

  validates :tenant_id, presence: true
  validates_uniqueness_of :user_id, scope: :tenant_id

  monetize :balance, as: :balance_cents

  def to_s
    user.email.to_s
  end

  extend FriendlyId
  friendly_id :to_s, use: :slugged

  after_touch do
    # update balance
    update_column :payments_sum, payments.map(&:amount).sum
    update_column :balance, payments_sum
  end

  include Roleable

end
