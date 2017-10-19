class Service < ApplicationRecord
  belongs_to :teenager
  belongs_to :client
  belongs_to :post
end