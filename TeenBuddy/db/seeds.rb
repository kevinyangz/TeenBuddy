# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Endorsement.delete_all
Transaction.delete_all
Service.delete_all
Post.delete_all
User.delete_all
TeenagerInterest.delete_all
Teenager.delete_all
Client.delete_all

FileUtils.rm_rf('public/uploads')


address_array = [['500 Kingston Rd Toronto ON', 'M4L 1V3'],
                 ['315 St Germain Ave Toronto ON', 'M5M 1W4'],
                 ['234 Willow Ave Toronto ON', 'M4E 3K7'],
                 ['26 Goodwood Park Cres East York ON', 'M4C 2G5']]

real_address = []
address_array.each {|record| real_address << {'address' => record[0], 'postal_code' => record[1]}}


# two constant account for testing


for i in 0..20
  address_index = Faker::Number.between(0, real_address.count()-1)


  User.create!(email: Faker::Internet.free_email, password: 123456, role: 'teenager',
                      teenager_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name,
                                            birth_date: Faker::Date.between(18.years.ago, 8.years.ago),
                                            cell_phone: Faker::PhoneNumber.cell_phone,
                                            home_address: real_address[address_index]['address'],
                                            postal_code: real_address[address_index]['postal_code']}
  )

  
end

for i in 0..20
  address_index = Faker::Number.between(0, real_address.count()-1)

 user = User.create!(email: Faker::Internet.free_email, password: 123456, role: 'client',
               client_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name,
                                   home_phone: Faker::PhoneNumber.phone_number, cell_phone: Faker::PhoneNumber.cell_phone,
                                   description: Faker::MostInterestingManInTheWorld.quote,
                                   home_address: real_address[address_index]['address'],
                                   postal_code: real_address[address_index]['postal_code']}
  )

  transaction =  Transaction.create!(user: user, inout: true, comment: 'Deposit', amount: 1000 * 100)

    puts "Deposit for user id #{user.id}, transaction id is #{transaction.id}"



end

Client.first.user.update(email: 'client@ut.com')
Teenager.first.user.update(email: 'teenager@ut.com')




# initialize Service types and category
ServiceCategory.delete_all
ServiceType.delete_all

many_service_categories = [{title: "Babysitting"},
                           {title: "Yard Work"},
                           {title: "Snow Shoveling"},
                           {title: "Furniture Moving"},
                           {title: "Simple Cleaning Tasks"},
                           {title: "Vacation Services"},
                           {title: "Dog Walking"},
                           {title: "Computer Help"},
                           {title: "Tutoring"},
                           {title: "Reading"}]
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



#start posting jobs

SomeClients = Client.all.sample(Faker::Number.between(Client.count/2, Client.count))

SomeClients.each do |client|

  address_index = Faker::Number.between(0, real_address.count()-1)

  post =  Post.create(title: Faker::Job.title,
               client: client,
               description: Faker::MostInterestingManInTheWorld.quote,
               work_address: real_address[address_index]['address'],
               pay: Faker::Number.between(1, 100),
               number_of_teenager_needed: Faker::Number.between(1, 10),
               service_category:ServiceCategory.find_by(title: "Babysitting"),
               service_type:ServiceType.find_by(title:'Babysitting')

  )
  puts "created post #{post.id} for client #{client.id}"

end

