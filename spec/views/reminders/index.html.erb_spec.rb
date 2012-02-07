require 'spec_helper'

describe "reminders/index" do
  before(:each) do
    assign(:reminders, [
      stub_model(Reminder,
        :name => "Name",
        :description => "MyText",
        :needs_response => false
      ),
      stub_model(Reminder,
        :name => "Name",
        :description => "MyText",
        :needs_response => false
      )
    ])
  end

  it "renders a list of reminders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
