class ClientReview < ApplicationRecord
  belongs_to :client
  belongs_to :teenager

  validates :review, :score, presence: true
  validates :score, format:{with: /[0-5]/}
end
