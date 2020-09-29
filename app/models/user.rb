class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :invitable,
         :confirmable,
         :trackable,
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
      user = User.where(email: access_token.info.email).first # check if user with such email exists
  
      unless user
        user = User.create(
           email: access_token.info.email,
           password: Devise.friendly_token[0,20]
        )
      end
      
      unless user.confirmed_at
        user.confirmed_at = Time.now #confirm user if he logs in with a social media account
      end

      user
  end

end
