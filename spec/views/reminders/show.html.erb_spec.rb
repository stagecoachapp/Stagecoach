require 'spec_helper'

describe "reminders/show" do
  before(:each) do
    @reminder = assign(:reminder, stub_model(Reminder,
      :name => "Name",
      :description => "MyText",
      :needs_response => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
