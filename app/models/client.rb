class Client < ApplicationRecord
  acts_as_tenant(:tenant)
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :projects, dependent: :restrict_with_error
  has_many :payments, as: :payable, dependent: :restrict_with_error
  # has_many :tasks, through: :projects

  validates :name, :email, presence: true

  def to_s
    name
  end

  include PublicActivity::Model
  tracked owner: proc { |controller, model| controller.current_user }
  tracked tenant_id: proc { ActsAsTenant.current_tenant.id }

end
