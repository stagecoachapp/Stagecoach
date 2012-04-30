require 'spec_helper'

describe "conversations/index" do
  before(:each) do
    assign(:conversations, [
      stub_model(Conversation),
      stub_model(Conversation)
    ])
  end

  it "renders a list of conversations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
