class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :invitable,
         :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github]

  has_many :members
  has_many :tenants, through: :members
  
  belongs_to :tenant, required: false #tenant_id = to get current_tenant; false = can exist without any tenants

  def to_s
    email
  end
  extend FriendlyId
  friendly_id :email, use: :slugged

  def self.from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first
  
      unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20],
           confirmed_at: Time.now
        )
      end
      user
  end

end
