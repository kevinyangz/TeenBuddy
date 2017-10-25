class Service < ApplicationRecord
  belongs_to :teenager
  belongs_to :client
  belongs_to :post

  enum service_categories: [:moving, :yard_work]    #add more service categories later
 
end