require 'rails_helper'

RSpec.describe Client, type: :model do

  it "is valid with valid attributes" do
    #c = Client.new(fname: "matt" , lname: "li", home_address: "123 bay" )

   # expect(c).to be_valid
  end

  it "is not valid without a name" do
    c = Client.new

    expect(c).to_not be_valid
  end
  it "is not valid without a description"
  it "is not valid without an address"
  it "is not valid without a phone number"
end
