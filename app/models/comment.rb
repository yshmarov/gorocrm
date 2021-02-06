class Comment < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :commentable, polymorphic: true
  belongs_to :member
  
  validates :content, presence: true

  def to_s
    content
  end

end