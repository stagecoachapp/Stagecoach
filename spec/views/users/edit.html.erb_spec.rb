require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "MyString",
      :email => "MyString",
      :phonenumber => "MyString",
      :smartphone => "MyString",
      :activated => false
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_name", :name => "user[name]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_phonenumber", :name => "user[phonenumber]"
      assert_select "input#user_smartphone", :name => "user[smartphone]"
      assert_select "input#user_activated", :name => "user[activated]"
    end
  end
end
