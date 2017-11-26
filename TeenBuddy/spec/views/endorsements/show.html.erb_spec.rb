require 'rails_helper'

RSpec.describe "endorsements/show", type: :view do
  before(:each) do
    @endorsement = assign(:endorsement, Endorsement.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
