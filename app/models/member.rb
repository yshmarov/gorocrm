class Member < ApplicationRecord
  belongs_to :user, counter_cache: true
  #User.find_each { |user| User.reset_counters(user.id, :members) }  
  #belongs_to :tenant #acts_as_tenant includes this
  acts_as_tenant(:tenant) #counter_cache is currently not supported for acts_as_tenant. Pull request https://github.com/ErwinM/acts_as_tenant/pull/225
  #validates_uniqueness_to_tenant :user_id 

  validates :tenant_id, presence: true
  validates_uniqueness_of :user_id, scope: :tenant_id

  def to_s
    user.email.to_s + tenant.name.to_s
  end
  extend FriendlyId
  friendly_id :to_s, use: :slugged

  # List user roles
  ROLES = [:admin, :editor, :viewer]
  #Member.find(13).update_attributes!(admin: true) #add admin in console

  # json column to store roles
  store_accessor :roles, *ROLES

  # Cast roles to/from booleans
  ROLES.each do |role|
    scope role, -> { where("roles @> ?", {role => true}.to_json) }
    define_method(:"#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"#{role}?") { send(role) }
  end

  def active_roles # Where value true
    ROLES.select { |role| send(:"#{role}?") }.compact
  end

end
