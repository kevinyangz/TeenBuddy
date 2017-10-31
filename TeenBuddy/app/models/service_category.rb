class ServiceCategory < ApplicationRecord
	has_many :posts
	has_many :service_types


		#add a join table relationship for teenag
	has_many :teenager_interests
	has_many :teenagers, through: :teenager_interests 
end
