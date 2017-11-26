class Endorsement < ApplicationRecord
  has_one :liker, :class_name => "User"
  has_one :liked, :class_name => "User"
end
