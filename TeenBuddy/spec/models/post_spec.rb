require 'rails_helper'

RSpec.describe Post, type: :model do

  user = User.create(email: Faker::Internet.free_email, password: 123456, role: 'client',
                     client_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name,
                                         home_phone: Faker::PhoneNumber.phone_number, cell_phone: Faker::PhoneNumber.cell_phone,
                                         description: Faker::MostInterestingManInTheWorld.quote,
                                         home_address: '123 Bay St',
                                         postal_code: 'M4y 1c9'}
  )

  transaction = Transaction.create!(user: user, inout: true, comment: 'Deposit', amount: 1000 * 100)

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


  it "is valid with valid attributes" do
    @oneServiceType = ServiceType.all.sample(1).first

    post = Post.create(title: Faker::Job.title,
                       client: user.client,
                       description: Faker::MostInterestingManInTheWorld.quote,
                       work_address: '123 bay st',
                       pay: Faker::Number.between(1, 100),
                       number_of_teenager_needed: Faker::Number.between(1, 10),
                       service_category_id: @oneServiceType.service_category_id,
                       service_type_id: @oneServiceType.id

    )

    expect(post).to be_valid
  end

  it "is not valid without a title" do
    @oneServiceType = ServiceType.all.sample(1).first

    post = Post.create(
                       client: user.client,
                       description: Faker::MostInterestingManInTheWorld.quote,
                       work_address: '123 bay st',
                       pay: Faker::Number.between(1, 100),
                       number_of_teenager_needed: Faker::Number.between(1, 10),
                       service_category_id: @oneServiceType.service_category_id,
                       service_type_id: @oneServiceType.id

    )

    expect(post).to_not be_valid
  end

  it "is not valid without a description" do
    @oneServiceType = ServiceType.all.sample(1).first

    post = Post.create(title: Faker::Job.title,
                       client: user.client,

                       work_address: '123 bay st',
                       pay: Faker::Number.between(1, 100),
                       number_of_teenager_needed: Faker::Number.between(1, 10),
                       service_category_id: @oneServiceType.service_category_id,
                       service_type_id: @oneServiceType.id

    )

    expect(post).to_not be_valid

  end

  it "is not valid without an address" do

    @oneServiceType = ServiceType.all.sample(1).first

    post = Post.create(title: Faker::Job.title,
                       client: user.client,
                       description: Faker::MostInterestingManInTheWorld.quote,

                       pay: Faker::Number.between(1, 100),
                       number_of_teenager_needed: Faker::Number.between(1, 10),
                       service_category_id: @oneServiceType.service_category_id,
                       service_type_id: @oneServiceType.id

    )

    expect(post).to_not be_valid

  end
  it "is not valid without pay" do

    @oneServiceType = ServiceType.all.sample(1).first

    post = Post.create(title: Faker::Job.title,
                       client: user.client,
                       description: Faker::MostInterestingManInTheWorld.quote,
                       work_address: '123 bay st',

                       number_of_teenager_needed: Faker::Number.between(1, 10),
                       service_category_id: @oneServiceType.service_category_id,
                       service_type_id: @oneServiceType.id

    )

    expect(post).to_not be_valid

  end

end
