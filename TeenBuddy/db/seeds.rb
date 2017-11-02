# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
user1=User.create!(email: "tester1@ut.com", password: "tester1",role:"teenager")
user2=User.create!(email: "tester2@ut.com", password: "tester2",role:"teenager")
user3=User.create!(email: "tester3@ut.com", password: "tester3",role:"teenager")
user4=User.create!(email: "tester4@ut.com", password: "tester4",role:"teenager")

user5=User.create!(email: "tester5@ut.com", password: "tester5",role:"client")
user6=User.create!(email: "tester6@ut.com", password: "tester6",role:"client")
user7=User.create!(email: "tester7@ut.com", password: "tester7",role:"client")
user8=User.create!(email: "tester8@ut.com", password: "tester8",role:"client")
user9=User.create!(email: "tester9@ut.com", password: "tester9",role:"client")

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

Client.delete_all
many_clients = [{user_id:user5.id,fname:"Yun", lname: "Ma", home_address: "123 Bay street", home_phone: "6471234567", cell_phone: "6472234567"},
                {user_id:user6.id,fname:"Jun", lname: "Lei", home_address: "223 Bay street", home_phone: "6472234567", cell_phone: "6472234567"},
                {user_id:user7.id,fname:"Huateng", lname: "Ma", home_address: "323 Bay street", home_phone: "6473234567", cell_phone: "6472234567"},
                {user_id:user8.id,fname:"Jianlin", lname: "Wang", home_address: "423 Bay street", home_phone: "6474234567", cell_phone: "6472234567"},
                {user_id:user9.id,fname:"Jiacheng", lname: "Li", home_address: "523 Bay street", home_phone: "6475234567", cell_phone: "6472234567"}]
many_clients.each do |c|
  Client.create!(c)
 end

Teenager.delete_all
TeenagerInterest.delete_all

teen1=Teenager.create!(user_id:user1.id,fname:"SiCeng",lname:"Wang",home_address:"123 Yonge Street",postal_code:"M5G 2R2",birth_date:"#{Date.new(2000,02,03)}",cell_phone:"6478801214")
teen2=Teenager.create!(user_id:user2.id,fname:"Gengxin",lname:"Lin",home_address:"666 Yonge Street",postal_code:"M5G 2R2",birth_date:"#{Date.new(1999,02,03)}",cell_phone:"6478801214")
teen3=Teenager.create!(user_id:user3.id,fname:"Trump",lname:"Duncun",home_address:"1232 Yonge Stree",postal_code:"M5G 2R2",birth_date:"#{Date.new(2003,02,03)}",cell_phone:"6478801214")
teen4=Teenager.create!(user_id:user4.id,fname:"Duncun",lname:"Tar",home_address:"123 Yonge Stree",postal_code:"M5G 2R2",birth_date:"#{Date.new(2012,02,03)}",cell_phone:"6478801214")
TeenagerInterest.create!(teenager_id:teen1.id,service_category_id:ServiceCategory.find_by(title: "Babysitting").id)
TeenagerInterest.create!(teenager_id:teen1.id,service_category_id:ServiceCategory.find_by(title: "Dog Walking").id)
TeenagerInterest.create!(teenager_id:teen1.id,service_category_id:ServiceCategory.find_by(title: "Tutoring").id)
TeenagerInterest.create!(teenager_id:teen2.id,service_category_id:ServiceCategory.find_by(title: "Reading").id)
TeenagerInterest.create!(teenager_id:teen3.id,service_category_id:ServiceCategory.find_by(title: "Babysitting").id)
TeenagerInterest.create!(teenager_id:teen3.id,service_category_id:ServiceCategory.find_by(title: "Simple Cleaning Tasks").id)
TeenagerInterest.create!(teenager_id:teen4.id,service_category_id:ServiceCategory.find_by(title: "Vacation Services").id)



