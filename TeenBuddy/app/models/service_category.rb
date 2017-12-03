class ServiceCategory < ApplicationRecord
	has_many :posts
	has_many :service_types, :dependent => :delete_all


		#add a join table relationship for teenag
	has_many :teenager_interests, :dependent => :delete_all
	has_many :teenagers, through: :teenager_interests


	def get_fa
		case self.title

			when"Babysitting" then'fa-child'
			when  "Yard Work" then 'fa-leaf'
			when "Snow Shoveling" then 'fa-snowflake-o'
			when "Furniture Moving"then 'fa-truck'
			when "Simple Cleaning Tasks"then 'fa-trash'
			when "Vacation Services"then 'fa-plane'
			when "Dog Walking"then 'fa-paw'
			when "Computer Help"then 'fa-laptop'
			when "Tutoring" then 'fa-group'
			when "Reading"then 'fa-book'
		end
	end
end
