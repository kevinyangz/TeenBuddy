class Transaction < ApplicationRecord
  belongs_to :client
  belongs_to :teenager
  belongs_to :service
  belongs_to :charge

  # validation
  validates :amount, numericality:{greater_than:0}

end