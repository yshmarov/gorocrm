class Member < ApplicationRecord
  belongs_to :user, counter_cache: true
  acts_as_tenant :tenant, counter_cache: true
  has_many :tasks, dependent: :restrict_with_error
  has_many :payments, as: :payable, dependent: :restrict_with_error

  validates :tenant_id, presence: true
  validates_uniqueness_of :user_id, scope: :tenant_id

  monetize :balance, as: :balance_cents

  def to_s
    full_name
  end

  extend FriendlyId
  friendly_id :to_s, use: :slugged

  after_touch do
    # update balance
    update_column :payments_sum, payments.map(&:amount).sum
    update_column :balance, payments_sum
  end

  def full_name
    [last_name, first_name, middle_name].join(" ")
  end

  def fullest_name
    [last_name, first_name, middle_name].join(" ")
  end


  include Roleable

end
