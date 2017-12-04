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


for i in 0..30
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

for i in 0..30
  address_index = Faker::Number.between(0, real_address.count()-1)

  user = User.create(email: Faker::Internet.free_email, password: 123456, role: 'client',:confirmed_at => DateTime.now,
                      client_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name, 
                                          home_phone: Faker::PhoneNumber.phone_number, cell_phone: Faker::PhoneNumber.cell_phone,
                                          description: Faker::MostInterestingManInTheWorld.quote,
                                          home_address: real_address[address_index]['address'],
                                          postal_code: real_address[address_index]['postal_code']}
  )

  transaction = Transaction.create!(user: user, inout: true, comment: 'Deposit (We charge 5% service fee.)', amount: 1500 * 100)

end

@myclient = Client.first
@myclient.user.update(email: 'client@ut.com')
@myclient.update(fname:'client', lname:'li')

@myteenager= Teenager.first
@myteenager.user.update(email: 'teenager@ut.com')
@myteenager.update( fname:'teenager', lname:'li')


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


# store tags

@teenagers = Teenager.all

@teenagers.each do |teenager|

  teenager.save

end







#setup some job array


#title, description,service_category,service_type

post_array=[['Need help to clean yard.','My yard has many leaves, need someone to clean them.',
             ServiceCategory.find_by(title: "Yard Work").id,ServiceType.find_by(title: "Leaf Raking").id ],
            ['Need someone to mow my lawn.','Need someone to help me.',
             ServiceCategory.find_by(title: "Yard Work").id,ServiceType.find_by(title: "Lawn Mowing").id],
            ['Need someone to mow my lawn.','Need someone to help me.',
             ServiceCategory.find_by(title: "Yard Work").id,ServiceType.find_by(title: "Lawn Mowing").id],
            ['Need someone to take care of my son.','Someone who can take care of our son and drop him at UTSG at 7.30 am every morning.',
             ServiceCategory.find_by(title: "Babysitting").id,ServiceType.find_by(title: "Babysitting").id],
            ['Need someone to take care of my son.','Someone who can take care of our son and drop him at UTSC at 7.30 am every morning.',
             ServiceCategory.find_by(title: "Babysitting").id,ServiceType.find_by(title: "Babysitting").id],
            ['Need someone to take care of my son.','Someone who can take care of our son and drop him at UofT at 7.30 am every morning.',
             ServiceCategory.find_by(title: "Babysitting").id,ServiceType.find_by(title: "Babysitting").id],
            ['Need someone to eliminate lawn weeds','Someone who can eliminate lawn weeds',
             ServiceCategory.find_by(title: "Yard Work").id,ServiceType.find_by(title: "Weeding").id],
            ['Need someone to clean the snow off my car','Need someone to clean the snow off my car every morning',
             ServiceCategory.find_by(title: "Snow Shoveling").id,ServiceType.find_by(title: "Snow Shoveling").id],
            ['Need someone to clean the snow off my truck','Need someone to clean the snow off my truck every morning',
             ServiceCategory.find_by(title: "Snow Shoveling").id,ServiceType.find_by(title: "Snow Shoveling").id],
            ['Move furniture','Need someone to move the piano to the basement',
             ServiceCategory.find_by(title: "Furniture Moving").id,ServiceType.find_by(title: "Furniture Moving").id],
            ['Move furniture','Need someone to carry the furniture i bought from ikea',
             ServiceCategory.find_by(title: "Furniture Moving").id,ServiceType.find_by(title: "Furniture Moving").id],
            ['Cleaning sidewalk','Need someone to clean sidewalk',
             ServiceCategory.find_by(title: "Simple Cleaning Tasks").id,ServiceType.find_by(title: "Simple Cleaning Tasks").id],
            ['Cleaning basement','Need someone to clean the basement',
             ServiceCategory.find_by(title: "Simple Cleaning Tasks").id,ServiceType.find_by(title: "Simple Cleaning Tasks").id],
            ['Cleaning kitchen','Need someone to clean the ktichen in the basement',
             ServiceCategory.find_by(title: "Simple Cleaning Tasks").id,ServiceType.find_by(title: "Simple Cleaning Tasks").id],
            ['Need someone to pick up mails','Leaving for vacation, need someone to pick up mails',
             ServiceCategory.find_by(title: "Vacation Services").id,ServiceType.find_by(title: "Mail Pickup").id],
            ['Need someone to pick up mails','Leaving for Vancover, need someone to pick up mails',
             ServiceCategory.find_by(title: "Vacation Services").id,ServiceType.find_by(title: "Mail Pickup").id],
            ['Need someone to pick up mails','Leaving for Seattle, need someone to pick up mails',
             ServiceCategory.find_by(title: "Vacation Services").id,ServiceType.find_by(title: "Mail Pickup").id],
            ['Need someone to pick up mails','Leaving for Toronto, need someone to pick up mails',
             ServiceCategory.find_by(title: "Vacation Services").id,ServiceType.find_by(title: "Mail Pickup").id],
            ['Need someone to feed my dog','Leaving for vacation, need someone to take care of my dog',
             ServiceCategory.find_by(title: "Vacation Services").id,ServiceType.find_by(title: "Pet Feeding").id],
            ['Need someone to feed my cat','Leaving for vacation, need someone to take care of my cat',
             ServiceCategory.find_by(title: "Vacation Services").id,ServiceType.find_by(title: "Pet Feeding").id],
            ['Need someone to walk my dog','Leaving for vacation, need someone to take care of my dog',
             ServiceCategory.find_by(title: "Vacation Services").id,ServiceType.find_by(title: "Dog Walking").id],
            ['Need someone to help me install Windows 10','I bought a new desktop with OS, need some help',
             ServiceCategory.find_by(title: "Computer Help").id,ServiceType.find_by(title: "Computer Help").id],
            ['Need someone to help me assemble desktop','Need someone to help me install new graphic card.',
             ServiceCategory.find_by(title: "Computer Help").id,ServiceType.find_by(title: "Computer Help").id],
            ['Math tutoring','Need someone to teach math',
             ServiceCategory.find_by(title: "Tutoring").id,ServiceType.find_by(title: "Tutoring").id],
            ['Science tutoring','Need someone to teach grade 10 science',
             ServiceCategory.find_by(title: "Tutoring").id,ServiceType.find_by(title: "Tutoring").id],
            ['Mandarin tutoring','Need someone to teach Mandarin',
             ServiceCategory.find_by(title: "Tutoring").id,ServiceType.find_by(title: "Tutoring").id],
            ['Cantonese tutoring','Need someone to teach Cantonese',
             ServiceCategory.find_by(title: "Tutoring").id,ServiceType.find_by(title: "Tutoring").id],
            ['French tutoring','Need someone to teach grade 10 French',
             ServiceCategory.find_by(title: "Tutoring").id,ServiceType.find_by(title: "Tutoring").id],
            ['English tutoring','Need someone to teach grade 10 English',
             ServiceCategory.find_by(title: "Tutoring").id,ServiceType.find_by(title: "Tutoring").id],
            ['Science tutoring','Need someone to teach grade 12 science',
             ServiceCategory.find_by(title: "Tutoring").id,ServiceType.find_by(title: "Tutoring").id],
            ['Reading assistant','Need someone to read news for me',
             ServiceCategory.find_by(title: "Reading").id,ServiceType.find_by(title: "Reading").id],
            ['Reading assistant','Need someone to read textbook for me',
             ServiceCategory.find_by(title: "Reading").id,ServiceType.find_by(title: "Reading").id],
            ['Reading assistant','Need someone to read history book for me',
             ServiceCategory.find_by(title: "Reading").id,ServiceType.find_by(title: "Reading").id],
            ['Reading assistant','Need someone to read articles for me',
             ServiceCategory.find_by(title: "Reading").id,ServiceType.find_by(title: "Reading").id],
           ]

real_post = []
post_array.each {|record| real_post << {'title' => record[0], 'description' => record[1],'service_category_id' => record[2],
             'service_type_id' => record[3]}}


#start posting jobs

for i in 0..15

  @SomeClients = Client.all.sample(Client.count/2)

  @SomeClients.each do |client|

    address_index = Faker::Number.between(0, real_address.count()-1)

    @oneServiceType = ServiceType.all.sample(1).first


    post_index = Faker::Number.between(0,real_post.count()-1)

    post = Post.create(title: real_post[post_index]['title'],
                       client: client,
                       description: real_post[post_index]['description'],
                       work_address: real_address[address_index]['address'],
                       pay: Faker::Number.between(1, 50),
                       number_of_teenager_needed: Faker::Number.between(1, 10),
                       service_category_id: real_post[post_index]['service_category_id'],
                       service_type_id: real_post[post_index]['service_type_id']

    )

  end
end

#teenager apply jobs

for i in 0..30
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
  service.update({status: :enrolled})
end



@someService = Service.where(status:[:enrolled])

@someService = @someService.sample(@someService.count/1.5)

@someService.each do |service|
  service.update({status: [:finished, :confirmed].sample(1).first})
end

client_comment=[['Very mean',1],
                ['Very nice man',4],
                ['give me too much work',1],
                ['good',5],
                ['alright',4],
                ["It's ok",3],
    ['Most amazing client ever, I love him.',5],
    ['Always calls me a slacker',2],
    ["it's not friday~",3],
    ['So annoying',2],
    ['her hair smells good',5],
    ['excellent job', 5],
    ['just okay', 3],
    ['not very good', 2],
    ['he is very friendly and nice', 5],
    ['I would like to work for him again', 5],
    ['great place to work and nice employer', 5],
    ['Good Boss!', 5],
    ['This client is a rude mand, he yield to me because I came late. Do not want to work for this guy', 1],
    ['The job is pretty easy and my client was so nice. High recommend', 4],
    ['I Hate working with this Rude man. Please do not work for this guy', 1],
    ['fair salary but bad guy', 3]]

client_comment_fake=[]
client_comment.each {|record| client_comment_fake << {'comment' => record[0], 'rating' => record[1]}}


teenager_comment=[['I will not recommend this guy, poor Service.',1],
  ['those kids are doing some wonderful jobs',4],
  ['This guy is very lazy, he eat during working hour',1],
  ['good',5],
  ['alright',4],
  ['Its ok',3],
  ['Most amazing kid ever, I love him.',5],
  ['slacker',2],
  ["He reminds me it's not friday everyday",3],
  ['So annoying',2],
  ['hard working kid',5],
  ['I would like to have him work for me again', 4],
  ['he did a good job at my place', 5],
  ['I will probably hire another guy next time', 1],
  ['This kid make my life easier!', 5],
  ['I wish to hire this kid again ', 5],
  ['Poor Service !', 2],
  ['Very Good Job!', 5],
  ['5 Star Review', 5],
  ['Professional service', 5],
  ['Highly recommend', 5],
  ['Amazing Kid, You could not image that how good he is ', 5],
    ['Why your website hire this guy, poor service ', 1]

]
teenager_comment_fake=[]
teenager_comment.each {|record| teenager_comment_fake << {'comment' => record[0], 'rating' => record[1]}}

#client rate some service

@someService = Service.where(status:[:confirmed])

@someService = @someService.sample(@someService.count/1.5)

@someService.each do |service|
  clientcomment_index = Faker::Number.between(0, client_comment.count()-1)

  service.update(client_review: client_comment_fake[clientcomment_index]['comment'],
  client_rating: client_comment_fake[clientcomment_index]['rating'])
end



#teenager rate some service

@someService = Service.where(status:[:confirmed])

@someService = @someService.sample(@someService.count/1.5)


@someService.each do |service|
    teen_comment_index = Faker::Number.between(0, teenager_comment.count()-1)
  service.update(teen_review: teenager_comment_fake[teen_comment_index]['comment'],
                 teen_rating: teenager_comment_fake[teen_comment_index]['rating'])
end

#endorsements

for i in 0..200
  Endorsement.create(liker:User.all.sample(1).first.id, liked:User.all.sample(1).first.id)

end

AdminUser.delete_all
AdminUser.create!(email: 'superadmin@example.com', password: '123456', password_confirmation: '123456', role:'superadmin') 
AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456', role:'admin') 