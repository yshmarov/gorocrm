class Tagging < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :taggable, polymorphic: true
  belongs_to :tag

end