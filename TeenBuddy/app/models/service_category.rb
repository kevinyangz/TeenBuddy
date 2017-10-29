class ServiceCategory < ApplicationRecord
	has_many :posts
	has_many :service_types
end
