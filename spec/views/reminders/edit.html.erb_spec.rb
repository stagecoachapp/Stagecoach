require 'spec_helper'

describe "reminders/edit" do
  before(:each) do
    @reminder = assign(:reminder, stub_model(Reminder,
      :name => "MyString",
      :description => "MyText",
      :needs_response => false
    ))
  end

  it "renders the edit reminder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reminders_path(@reminder), :method => "post" do
      assert_select "input#reminder_name", :name => "reminder[name]"
      assert_select "textarea#reminder_description", :name => "reminder[description]"
      assert_select "input#reminder_needs_response", :name => "reminder[needs_response]"
    end
  end
end
