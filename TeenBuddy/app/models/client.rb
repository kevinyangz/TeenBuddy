class Client < ApplicationRecord
  has_many :posts
  has_many :services

  belongs_to :user
  validates :fname, :lname, presence: true
  validates :fname, :lname, length: { minimum: 2 }

    mount_uploader :selfie, SelifieUploader

end
