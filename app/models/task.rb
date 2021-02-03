class Task < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :project
  validates :name, :status, presence: true
  
  def to_s
    name
  end

  STATUSES = [:planned, :progress, :done]
  def self.statuses
    STATUSES.map { |status| [status, status] }
  end

end
