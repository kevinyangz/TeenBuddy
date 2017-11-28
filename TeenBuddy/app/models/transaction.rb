class Transaction < ApplicationRecord
  belongs_to :user

  # validation
  validates :amount, numericality:{greater_than:0}

end