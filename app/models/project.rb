class Project < ApplicationRecord
  belongs_to :tenant
  belongs_to :client
end
