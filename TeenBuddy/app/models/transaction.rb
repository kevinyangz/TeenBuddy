class Transaction < ApplicationRecord
  belongs_to :user

  # validation
  validates :amount, numericality:{greater_than:0}

  def self.getTotalProfit
  	totalAmount = Transaction.all.where('comment LIKE ?', "Deposit (We charge 5% service fee.)").sum(:amount)
  	totalAmount = (totalAmount/0.95)*0.05/100
  end

end