require 'spec_helper'

describe "conversations/edit" do
  before(:each) do
    @conversation = assign(:conversation, stub_model(Conversation))
  end

  it "renders the edit conversation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => conversations_path(@conversation), :method => "post" do
    end
  end
end
