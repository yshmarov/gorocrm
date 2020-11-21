class User::Identity < ApplicationRecord
  serialize :auth, JSON

  belongs_to :user
end
