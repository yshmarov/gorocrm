# == Schema Information
#
# Table name: user_identities
#
#  id       :bigint           not null, primary key
#  user_id  :bigint
#  provider :string
#  uid      :string
#  auth     :text
#
class User::Identity < ApplicationRecord
  serialize :auth, JSON

  belongs_to :user
end
