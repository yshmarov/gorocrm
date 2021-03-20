class Client < ApplicationRecord
  acts_as_tenant(:tenant)
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :projects, dependent: :restrict_with_error
  has_many :payments, as: :payable, dependent: :restrict_with_error
  has_many :tasks, through: :projects
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  monetize :balance, as: :balance_cents

  def to_s
    name
  end

  include PublicActivity::Model
  tracked owner: proc { |controller, model| controller.current_user }
  tracked tenant_id: proc { ActsAsTenant.current_tenant.id }

  after_touch do
    # update balance
    update_column :payments_sum, payments.map(&:amount).sum
    update_column :balance, payments_sum
  end

end
