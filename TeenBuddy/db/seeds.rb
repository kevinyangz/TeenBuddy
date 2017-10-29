# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
many_clients = [{fname:"Yun", lname: "Ma", home_address: "123 Bay street", home_phone: "6471234567", cell_phone: "6472234567"},
                {fname:"Jun", lname: "Lei", home_address: "223 Bay street", home_phone: "6472234567", cell_phone: "6472234567"},
                {fname:"Huateng", lname: "Ma", home_address: "323 Bay street", home_phone: "6473234567", cell_phone: "6472234567"},
                {fname:"Jianlin", lname: "Wang", home_address: "423 Bay street", home_phone: "6474234567", cell_phone: "6472234567"},
                {fname:"Jiacheng", lname: "Li", home_address: "523 Bay street", home_phone: "6475234567", cell_phone: "6472234567"}]
many_clients.each do |c|
  Client.create(c)
 end


many_teenagers= [{fname:"Ian",lname:"JAMEs",home_address:"123 Yonge Street",postal_code:"M5G 2R2",birth_date:"#{Date.new(2000,02,03)}",cell_phone:"6478801214"},
				 {fname:"Ian1",lname:"JAMES",home_address:"666 Yonge Street",postal_code:"M5G 2R2",birth_date:"#{Date.new(1999,02,03)}",cell_phone:"6478801214"},
				 {fname:"Ian2",lname:"JAMES",home_address:"1232 Yonge Stree",postal_code:"M5G 2R2",birth_date:"#{Date.new(2003,02,03)}",cell_phone:"6478801214"},
				 {fname:"Ian3",lname:"JAMES",home_address:"123 Yonge Stree",postal_code:"M5G 2R2",birth_date:"#{Date.new(2012,02,03)}",cell_phone:"6478801214"}
]
many_teenagers.each do |c|
  Teenager.create(c)
end

ServiceCategory.delete_all
ServiceType.delete_all

many_service_categories = [{title: "babysitting"}, {title: "yard working"}]
many_service_categories.each do |sc|
	ServiceCategory.create!(sc)
end

ServiceType.create!(title: "babysitting", service_category_id: ServiceCategory.find_by(title: "babysitting").id)