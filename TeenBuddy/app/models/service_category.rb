class ServiceCategory < ApplicationRecord
	has_many :posts
	has_many :service_types, :dependent => :delete_all


		#add a join table relationship for teenag
	has_many :teenager_interests, :dependent => :delete_all
	has_many :teenagers, through: :teenager_interests 
end
