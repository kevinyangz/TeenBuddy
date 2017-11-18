class TeenagerInterest < ApplicationRecord
	belongs_to :teenager
	belongs_to :service_category

  include Filterable
  scope :servicecategory, -> (servicecategory) { where service_category_id: servicecategory }
end
