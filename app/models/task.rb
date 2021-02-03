class Task < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :project
  validates :name, presence: true
  
  def to_s
    name
  end

end
