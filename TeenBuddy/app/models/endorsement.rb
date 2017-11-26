class Endorsement < ApplicationRecord
  belongs_to :user
  has_one :teenager
  has_one :client
end
