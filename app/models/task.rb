class Task < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :project, counter_cache: true
  belongs_to :member, counter_cache: true
  belongs_to :creator, class_name: "Member", foreign_key: :creator_id
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, :status, presence: true

  scope :planned, -> { where(status: "planned") }
  scope :progress, -> { where(status: "progress") }
  scope :done, -> { where(status: "done") }
  # scope :mine, -> { where(member: current_user.member) }
  # scope :overdue, -> { where(status: "done").where("deadline < ?", Time.zone.now) }  

  def to_s
    name
  end

  STATUSES = [:planned, :progress, :done]
  def self.statuses
    STATUSES.map { |status| [status, status] }
  end

  # for calendar
  def calendar_date
    if done_at.present?
      done_at
    else
      created_at
    end
  end

  # for calendar
  def status_color
    if status == "planned"
      "danger"
    elsif status == "progress"
      "warning"
    elsif status == "done"
      "success"
    else
      "danger"
    end
  end

  include PublicActivity::Model
  tracked owner: proc { |controller, model| controller.current_user }
  tracked tenant_id: proc { ActsAsTenant.current_tenant.id }

end
