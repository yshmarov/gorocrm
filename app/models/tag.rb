class Tag < ApplicationRecord
  acts_as_tenant(:tenant)
  validates :name, :category, presence: true
	validates :name, length: {minimum: 1, maximum: 25}, uniqueness: { scope: :category,
    message: "uniquene per category" }
  
  def to_s
    name
  end

  CATEGORIES = [:client, :payment, :task, :project]
  def self.categories
    CATEGORIES.map { |category| [category, category] }
  end

	has_many :taggings, dependent: :destroy

end
