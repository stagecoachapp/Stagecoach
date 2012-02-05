require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :name => "MyString",
      :email => "MyString",
      :phonenumber => "MyString",
      :smartphone => "MyString",
      :activated => false
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_name", :name => "user[name]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_phonenumber", :name => "user[phonenumber]"
      assert_select "input#user_smartphone", :name => "user[smartphone]"
      assert_select "input#user_activated", :name => "user[activated]"
    end
  end
end
