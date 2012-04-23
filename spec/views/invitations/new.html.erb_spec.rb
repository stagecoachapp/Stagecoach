require 'spec_helper'

describe "invitations/new" do
  before(:each) do
    assign(:invitation, stub_model(Invitation).as_new_record)
  end

  it "renders new invitation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invitations_path, :method => "post" do
    end
  end
end
