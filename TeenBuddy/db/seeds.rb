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
                 ['26 Goodwood Park Cres East York ON', 'M4C 2G5'],
                 ['750 Bloor St W, Toronto, ON', 'M6G 3K4'],
                 ['8 Park Rd, Toronto, ON', 'M4W 3S5'],
                 ['37 Grosvenor St, Toronto, ON', 'M4Y 3G5'],
                 ['761 Bay St, Toronto, ON', 'M5G 2R2'],
                 ["1 King's College Cir, Toronto, ON", 'M5S 1A8'],
                 ['2 Dundas St W, Toronto, ON', 'M5B 1R4'],
                 ['200 Elizabeth St, Toronto, ON', 'M5G 2C4'],
                 ['207 Beverley St, Toronto, ON', 'M5T 1Z4'],
                 ['150 Dupont St, Toronto, ON', 'M5R 2E6'],
                 ['274 Parliament St, Toronto, ON', 'M5A 3A4'],
                 ['265 Front St E, Toronto, ON', 'M5A 1G1'],
                 ['11 Sunlight Park Rd, Toronto, ON', 'M4M 1B5'],
                 ['479 Broadview Ave, Toronto, ON', 'M4K 2N4'],
                 ['16 Bayfield Crescent, Toronto, ON', 'M4K 2V4'],
                 ['569 Fairlawn Ave, North York, ON', 'M5M 1V7'],
                 ['2005 Avenue Rd, North York, ON', 'M5M 4A5'],
                 ['243 Winnett Ave, York, ON', 'M6C 3L8'],
                 ['2032 Dufferin St, York, ON', 'M6E 3R5'],
                 ['904 Dufferin St, Toronto, ON', 'M6H 4A9'],
                 ['1150 Queen St W, Toronto, ON', 'M6J 1J3'],
                 ['800 Dundas St W, Toronto, ON', 'M6J 1V1'],
                 ['520 Bloor St W, Toronto, ON', 'M5S 1Y3'],
                 ['1208 Yonge St, Toronto, ON', 'M4T 1W1'],
                 ['21 Rippleton Rd, North York, ON', 'M3B 1H4'],
                 ['81 Harrison Rd, North York, ON', 'M2L 1V9']]

real_address = []
address_array.each {|record| real_address << {'address' => record[0], 'postal_code' => record[1]}}


# two constant account for testing


for i in 0..50
  address_index = Faker::Number.between(0, real_address.count()-1)


  User.create(email: Faker::Internet.free_email, password: 123456, role: 'teenager',:confirmed_at => DateTime.now,
               teenager_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name, 
                                     birth_date: Faker::Date.between(18.years.ago, 8.years.ago),
                                     cell_phone: Faker::PhoneNumber.cell_phone,
                                     description: Faker::MostInterestingManInTheWorld.quote,
                                     home_address: real_address[address_index]['address'],
                                     postal_code: real_address[address_index]['postal_code']}
  )


end

for i in 0..50
  address_index = Faker::Number.between(0, real_address.count()-1)

  user = User.create(email: Faker::Internet.free_email, password: 123456, role: 'client',:confirmed_at => DateTime.now,
                      client_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name, 
                                          home_phone: Faker::PhoneNumber.phone_number, cell_phone: Faker::PhoneNumber.cell_phone,
                                          description: Faker::MostInterestingManInTheWorld.quote,
                                          home_address: real_address[address_index]['address'],
                                          postal_code: real_address[address_index]['postal_code']}
  )

  transaction = Transaction.create!(user: user, inout: true, comment: 'Deposit', amount: 1000 * 100)

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



#add teenager interests

for i in 0..5
  @SomeTeenagers = Teenager.all.sample(Teenager.count/2)

  @SomeTeenagers.each do |teenager|


  TeenagerInterest.create(teenager:teenager, service_category: ServiceCategory.all.sample(1).first)

  end


end










#setup some job array






#start posting jobs

for i in 0..20

  @SomeClients = Client.all.sample(Client.count/2)

  @SomeClients.each do |client|

    address_index = Faker::Number.between(0, real_address.count()-1)

    @oneServiceType = ServiceType.all.sample(1).first


    post = Post.create(title: Faker::Job.title,
                       client: client,
                       description: Faker::MostInterestingManInTheWorld.quote,
                       work_address: real_address[address_index]['address'],
                       pay: Faker::Number.between(1, 100),
                       number_of_teenager_needed: Faker::Number.between(1, 10),
                       service_category_id: @oneServiceType.service_category_id,
                       service_type_id: @oneServiceType.id

    )

  end
end

#teenager apply jobs

for i in 0..20
  @someTeenagers = Teenager.all.sample(Teenager.count/2)

  @someTeenagers.each do |teenager|


    Service.create(teenager: teenager,
                   post: Post.all.sample(1).first,
                   status: :applied,
                   enrollType: true,
                   applyMessage: Faker::MostInterestingManInTheWorld.quote

    )
  end
end


#client invite teenagers


for i in 0..4
  @somePosts = Post.all.sample(Post.count/2)

  @somePosts.each do |post|


    Service.create(teenager: Teenager.all.sample(1).first,
                   post: post,
                   status: :beingInvited,
                   enrollType: false,
                   inviteMessage: Faker::MostInterestingManInTheWorld.quote

    )
  end
end

#accept/finish/confirm some offer

@someService = Service.where(status:[:applied,:beingInvited])

@someService = @someService.sample(@someService.count/1.5)


@someService.each do |service|
  service.update({status: [:enrolled, :finished, :confirmed].sample(1).first})
end

#client rate some service

@someService = Service.where(status:[:confirmed])

@someService = @someService.sample(@someService.count/1.5)


@someService.each do |service|
  service.update(client_review: Faker::MostInterestingManInTheWorld.quote,
  client_rating: Faker::Number.between(1, 5))
end


#teenager rate some service

@someService = Service.where(status:[:confirmed])

@someService = @someService.sample(@someService.count/2)


@someService.each do |service|
  service.update(teen_review: Faker::MostInterestingManInTheWorld.quote,
                 teen_rating: Faker::Number.between(1, 5))
end

#endorsements

for i in 0..200
  Endorsement.create(liker:User.all.sample(1).first.id, liked:User.all.sample(1).first.id)

end

AdminUser.delete_all

AdminUser.create!(email: 'superadmin@example.com', password: '123456', password_confirmation: '123456', role:'superadmin') 
AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456', role:'admin') 