class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :invitable,
         :confirmable,
         :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github]

  has_many :identities, dependent: :destroy
  has_many :members
  has_many :tenants, through: :members
  
  belongs_to :tenant, required: false #tenant_id = to get current_tenant; false = can exist without any tenants

  def to_s
    email
  end

  def username
    if self.name.present?
      name
    else
      self.email.split(/@/).first
    end
  end

  extend FriendlyId
  friendly_id :email, use: :slugged

end
