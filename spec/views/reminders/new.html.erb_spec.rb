require 'spec_helper'

describe "reminders/new" do
  before(:each) do
    assign(:reminder, stub_model(Reminder,
      :name => "MyString",
      :description => "MyText",
      :needs_response => false
    ).as_new_record)
  end

  it "renders new reminder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reminders_path, :method => "post" do
      assert_select "input#reminder_name", :name => "reminder[name]"
      assert_select "textarea#reminder_description", :name => "reminder[description]"
      assert_select "input#reminder_needs_response", :name => "reminder[needs_response]"
    end
  end
end
