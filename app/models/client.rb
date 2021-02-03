class Client < ApplicationRecord
  acts_as_tenant(:tenant)

  validates :name, :email, presence: true

  def to_s
    name
  end

end
