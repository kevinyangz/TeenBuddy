class Client < ApplicationRecord
  has_many :posts
  belongs_to :user
  validates :fname, :lname, :home_address, :cell_phone, presence: true
  validates :fname, :lname, length: { minimum: 2 }
end
