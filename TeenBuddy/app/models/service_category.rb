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
			when "Furniture Moving"then
			when "Simple Cleaning Tasks"then
			when "Vacation Services"then
			when "Dog Walking"then
			when "Computer Help"then
			when "Tutoring" then
			when "Reading"then
		end
	end
end
