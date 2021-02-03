class Payment < ApplicationRecord
  acts_as_tenant(:tenant)
  belongs_to :payable, polymorphic: true
  validates :amount, presence: true

  def to_s
    [payable_type, payable_id].join(" ")
  end

end
