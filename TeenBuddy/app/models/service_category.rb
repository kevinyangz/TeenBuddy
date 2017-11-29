class ServiceCategory < ApplicationRecord
	has_many :posts, :dependent => :destroy
	has_many :service_types, :dependent => :destroy


		#add a join table relationship for teenag
	has_many :teenager_interests, :dependent => :destroy
	has_many :teenagers, through: :teenager_interests 
end
