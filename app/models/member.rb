# == Schema Information
#
# Table name: members
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  tenant_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  roles      :jsonb            not null
#  slug       :string
#
class Member < ApplicationRecord
  belongs_to :user, counter_cache: true
  # User.find_each { |x| User.reset_counters(x.id, :members) }
  # Tenant.find_each { |x| Tenant.reset_counters(x.id, :members) }
  # belongs_to :tenant #acts_as_tenant includes this
  # acts_as_tenant(:tenant, counter_cache: true)
  acts_as_tenant :tenant, counter_cache: true
  # validates_uniqueness_to_tenant :user_id

  validates :tenant_id, presence: true
  validates_uniqueness_of :user_id, scope: :tenant_id

  def to_s
    user.email.to_s + tenant.name.to_s
  end
  extend FriendlyId
  friendly_id :to_s, use: :slugged

  # List member roles
  ROLES = [:admin, :partner, :employee]
  # Member.find(13).update_attributes!(admin: true) #add admin in console

  # json column to store roles
  store_accessor :roles, *ROLES

  # boolean roles
  ROLES.each do |role|
    scope role, -> { where("roles @> ?", {role => true}.to_json) }
    define_method(:"#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"#{role}?") { send(role) }
  end

  def active_roles # Where value true
    ROLES.select { |role| send(:"#{role}?") }.compact
  end

  # role validation
  validate :must_have_a_role, on: :update
  validate :must_have_an_admin

  private

  def must_have_an_admin
    if persisted? &&
        (tenant.members.where.not(id: id).pluck(:roles).count { |h| h["admin"] == true } < 1) &&
        roles_changed? && admin == false
      errors.add(:base, "The tenant must have at least one admin")
    end
  end

  def must_have_a_role
    if roles.values.none?
      errors.add(:base, "A member must have at least one role")
    end
  end
end
