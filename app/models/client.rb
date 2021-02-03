class Client < ApplicationRecord
  acts_as_tenant(:tenant)
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, :email, presence: true

  def to_s
    name
  end

end
