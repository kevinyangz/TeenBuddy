class Client < ApplicationRecord
  has_many :posts

  validates :fname, :lname, :homeaddress, :cell_phone, presence: true
  validates :fname, :lname, length: { minimum: 2 }
end
