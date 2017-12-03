require 'rails_helper'

RSpec.describe Teenager, type: :model do

  it "is valid with valid attributes" do
    #@c = Client.new(fname: "matt" , lname: "li", home_address: "123 bay", description: "I'm not fat", home_phone: "123456789", cell_phone:"123456789" )
    user = User.create(email: Faker::Internet.free_email, password: 123456, role: 'teenager',
                       teenager_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name,
                                             birth_date: Faker::Date.between(18.years.ago, 8.years.ago),
                                             cell_phone: Faker::PhoneNumber.cell_phone,
                                             description: Faker::MostInterestingManInTheWorld.quote,
                                             home_address: '123 Bay St',
                                             postal_code: 'M4y 1c9'}
    )

    expect(user).to be_valid
  end

  it "is not valid without birthday" do
    user = User.create(email: Faker::Internet.free_email, password: 123456, role: 'teenager',
                       teenager_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name,

                                             cell_phone: Faker::PhoneNumber.cell_phone,
                                             description: Faker::MostInterestingManInTheWorld.quote,
                                             home_address: '123 Bay St',
                                             postal_code: 'M4y 1c9'}
    )

    expect(user).to_not be_valid
  end

  it "is not valid without a name" do
    user = User.create(email: Faker::Internet.free_email, password: 123456, role: 'teenager',
                       teenager_attributes: {
                                             birth_date: Faker::Date.between(18.years.ago, 8.years.ago),
                                             cell_phone: Faker::PhoneNumber.cell_phone,
                                             description: Faker::MostInterestingManInTheWorld.quote,
                                             home_address: '123 Bay St',
                                             postal_code: 'M4y 1c9'}
    )

    expect(user).to_not be_valid
  end

  it "is not valid if too old" do
    user = User.create(email: Faker::Internet.free_email, password: 123456, role: 'teenager',
                       teenager_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name,
                                             birth_date: Faker::Date.between(80.years.ago, 20.years.ago),
                                             cell_phone: Faker::PhoneNumber.cell_phone,
                                             description: Faker::MostInterestingManInTheWorld.quote,
                                             home_address: '123 Bay St',
                                             postal_code: 'M4y 1c9'}
    )

    expect(user).to_not be_valid
  end

  it "is valid without a description" do
    user = User.create(email: Faker::Internet.free_email, password: 123456, role: 'teenager',
                       teenager_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name,
                                             birth_date: Faker::Date.between(18.years.ago, 8.years.ago),
                                             cell_phone: Faker::PhoneNumber.cell_phone,

                                             home_address: '123 Bay St',
                                             postal_code: 'M4y 1c9'}
    )

    expect(user).to be_valid

  end

  it "is not valid without an address" do

    user = User.create(email: Faker::Internet.free_email, password: 123456, role: 'teenager',
                       teenager_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name,
                                             birth_date: Faker::Date.between(18.years.ago, 8.years.ago),
                                             cell_phone: Faker::PhoneNumber.cell_phone,
                                             description: Faker::MostInterestingManInTheWorld.quote,

                                             postal_code: 'M4y 1c9'}
    )

    expect(user).to_not be_valid

  end
  it "is not valid without cell phone number" do

    user = User.create(email: Faker::Internet.free_email, password: 123456, role: 'teenager',
                       teenager_attributes: {fname: Faker::Name.first_name, lname: Faker::Name.last_name,
                                             birth_date: Faker::Date.between(18.years.ago, 8.years.ago),

                                             description: Faker::MostInterestingManInTheWorld.quote,
                                             home_address: '123 Bay St',
                                             postal_code: 'M4y 1c9'}
    )

    expect(user).to_not be_valid

  end

end
