class Transaction < ApplicationRecord
  belongs_to :client
  belongs_to :teenager
  belongs_to :service

  # validation
  validates :amount, numericality:{greater_than:0}

end