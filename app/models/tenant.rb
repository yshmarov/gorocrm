class Tenant < ApplicationRecord
  
  validates :name, presence: true, uniqueness: true
  validates :name, length: { in: 2..20 }
  RESERVED_NAMES = %w(blog app pricing terms help support tenant tenants user users)
  validates :name, exclusion: { in: RESERVED_NAMES, message: "%{value} is reserved." }

  validates :plan, presence: true
  RESERVED_PLANS = %w(solo team)
  validates :plan, inclusion: { in: RESERVED_PLANS, message: "%{value} is not available." }
  PLANS = [:solo, :team]

  has_many :members, dependent: :destroy
  has_many :users, through: :members

  def to_s
    name
  end

  extend FriendlyId
  friendly_id :name, use: :slugged
  def should_generate_new_friendly_id? #will change the slug if the name changed
    #source https://www.rubydoc.info/github/norman/friendly_id/FriendlyId%2FSlugged:should_generate_new_friendly_id%3F
    name_changed?
  end
  
  def can_invite_members?
    self.plan == "team"
  end
end
