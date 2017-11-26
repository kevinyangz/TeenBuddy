require 'rails_helper'

RSpec.describe "endorsements/index", type: :view do
  before(:each) do
    assign(:endorsements, [
      Endorsement.create!(),
      Endorsement.create!()
    ])
  end

  it "renders a list of endorsements" do
    render
  end
end
