class Teenager < ApplicationRecord
  has_many :services
  has_many :JobApplications
end