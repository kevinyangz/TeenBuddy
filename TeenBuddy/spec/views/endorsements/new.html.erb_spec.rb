require 'rails_helper'

RSpec.describe "endorsements/new", type: :view do
  before(:each) do
    assign(:endorsement, Endorsement.new())
  end

  it "renders new endorsement form" do
    render

    assert_select "form[action=?][method=?]", endorsements_path, "post" do
    end
  end
end
