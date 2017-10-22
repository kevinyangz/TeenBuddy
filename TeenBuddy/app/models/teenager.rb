class Teenager < ApplicationRecord
  has_many :services
  has_many :JobApplications
  
  #Validate Canadian Postal Code. Need to use gem if more countries need to be checked.
  canadian_postal_code = /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}\z/
  validates :postal_code, format: { with: canadian_postal_code }
  validates :fname, presence: true
  validates :lname,presence: true
  validates :home_address,presence: true
  validates :cell_phone,presence: true
  validates :birth_date, presence:true
  #
end