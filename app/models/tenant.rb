# == Schema Information
#
# Table name: tenants
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  slug          :string
#  members_count :integer          default(0), not null
#
class Tenant < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :name, length: {in: 2..20}
  RESERVED_NAMES = %w[blog app pricing terms help support tenant tenants user users]
  validates :name, exclusion: {in: RESERVED_NAMES, message: "%{value} is reserved."}

  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :contacts, dependent: :destroy

  def to_s
    name
  end

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  def should_generate_new_friendly_id?
    # will change the slug if the name changed
    # source https://www.rubydoc.info/github/norman/friendly_id/FriendlyId%2FSlugged:should_generate_new_friendly_id%3F
    # https://norman.github.io/friendly_id/FriendlyId/History.html
    name_changed?
  end

  has_one_attached :logo
  validates :logo, content_type: [:png, :jpg, :jpeg],
                   size: {less_than: 100.kilobytes, message: "Logo has to be under 100 kilobytes"}

  has_one :subscription, dependent: :destroy
  has_many :charges, dependent: :restrict_with_error
  has_one :plan, through: :subscription

  def can_invite_members?
    members_count < plan.max_members
  end
end
