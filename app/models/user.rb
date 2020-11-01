class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :invitable,
    :confirmable,
    :trackable,
    :omniauthable, omniauth_providers: [:google_oauth2, :github]

  has_many :identities, dependent: :destroy
  has_many :members
  has_many :tenants, through: :members

  # tenant_id = to get current_tenant; false = can exist without any tenants
  belongs_to :tenant, required: false

  def to_s
    email
  end

  def username
    if name.present?
      name
    else
      email.split(/@/).first
    end
  end

  extend FriendlyId
  friendly_id :email, use: :slugged
end
