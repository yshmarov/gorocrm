class Tag < ApplicationRecord
  acts_as_tenant(:tenant)
  validates :name, :category, presence: true
  
  def to_s
    name
  end

  CATEGORIES = [:client, :payment, :task, :project]
  def self.categories
    CATEGORIES.map { |category| [category, category] }
  end

end
