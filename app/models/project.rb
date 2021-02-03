class Project < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :client
  validates :client, :name, presence: true

  def to_s
    name
  end

end
