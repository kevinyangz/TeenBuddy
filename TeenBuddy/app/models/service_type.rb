class ServiceType < ApplicationRecord
	belongs_to :service_category
	has_many :posts

end
