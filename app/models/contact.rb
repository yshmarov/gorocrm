# == Schema Information
#
# Table name: contacts
#
#  id                 :bigint           not null, primary key
#  first_name         :string
#  last_name          :string
#  phone_number       :string
#  email              :string
#  tenant_id          :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  source             :string
#  import_id          :string
#  created_session_id :string
#
class Contact < ApplicationRecord
  acts_as_tenant(:tenant)

  # validates :first_name, :last_name, :phone_number, :email, presence: true
  validates :email, presence: true
end
