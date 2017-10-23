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