require 'spec_helper'

describe "user_roles/edit" do
  before(:each) do
    @user_role = assign(:user_role, stub_model(UserRole,
      :name => "MyString"
    ))
  end

  it "renders the edit user_role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_roles_path(@user_role), :method => "post" do
      assert_select "input#user_role_name", :name => "user_role[name]"
    end
  end
end
