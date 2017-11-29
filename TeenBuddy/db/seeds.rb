# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all

for i in 0..10
	user = User.create!(email: Faker::Internet.free_email, password: 123456, role:'teenager',
  teenager_attributes: {fname:Faker::Name.first_name, lname:Faker::Name.last_name}
  )
end

for i in 0..10
	user = User.create!(email: Faker::Internet.free_email, password: 123456, role:'client',
                      client_attributes: {fname:Faker::Name.first_name, lname:Faker::Name.last_name}
	)
end




ServiceCategory.delete_all
ServiceType.delete_all

many_service_categories = [ {title: "Babysitting"}, 
							{title: "Yard Work"},
							{title: "Snow Shoveling"},
							{title: "Furniture Moving"},
							{title: "Simple Cleaning Tasks"},
							{title: "Vacation Services"},
							{title: "Dog Walking"},
							{title: "Computer Help"},
							{title: "Tutoring"},
							{title: "Reading"} ]
many_service_categories.each do |sc|
	ServiceCategory.create!(sc)
end

ServiceType.create!(title: "Babysitting", service_category_id: ServiceCategory.find_by(title: "Babysitting").id)
ServiceType.create!(title: "Lawn Mowing", service_category_id: ServiceCategory.find_by(title: "Yard Work").id)
ServiceType.create!(title: "Leaf Raking", service_category_id: ServiceCategory.find_by(title: "Yard Work").id)
ServiceType.create!(title: "Weeding", service_category_id: ServiceCategory.find_by(title: "Yard Work").id)
ServiceType.create!(title: "Snow Shoveling", service_category_id: ServiceCategory.find_by(title: "Snow Shoveling").id)
ServiceType.create!(title: "Furniture Moving", service_category_id: ServiceCategory.find_by(title: "Furniture Moving").id)
ServiceType.create!(title: "Simple Cleaning Tasks", service_category_id: ServiceCategory.find_by(title: "Simple Cleaning Tasks").id)
ServiceType.create!(title: "Mail Pickup", service_category_id: ServiceCategory.find_by(title: "Vacation Services").id)
ServiceType.create!(title: "Pet Feeding", service_category_id: ServiceCategory.find_by(title: "Vacation Services").id)
ServiceType.create!(title: "Lawn Watering", service_category_id: ServiceCategory.find_by(title: "Vacation Services").id)
ServiceType.create!(title: "Dog Walking", service_category_id: ServiceCategory.find_by(title: "Dog Walking").id)
ServiceType.create!(title: "Computer Help", service_category_id: ServiceCategory.find_by(title: "Computer Help").id)
ServiceType.create!(title: "Tutoring", service_category_id: ServiceCategory.find_by(title: "Tutoring").id)
ServiceType.create!(title: "Reading", service_category_id: ServiceCategory.find_by(title: "Reading").id)

