require 'rails_helper'

RSpec.describe "endorsements/edit", type: :view do
  before(:each) do
    @endorsement = assign(:endorsement, Endorsement.create!())
  end

  it "renders the edit endorsement form" do
    render

    assert_select "form[action=?][method=?]", endorsement_path(@endorsement), "post" do
    end
  end
end
