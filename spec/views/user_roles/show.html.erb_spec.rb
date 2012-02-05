require 'spec_helper'

describe "user_roles/show" do
  before(:each) do
    @user_role = assign(:user_role, stub_model(UserRole,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
