class Service < ApplicationRecord
  belongs_to :teenager
  belongs_to :post

  enum status: [:open, :beingInvited, :applied, :enrolled, :finished, :confirmed]


end