require 'spec_helper'

describe "messages/show" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :text => "MyText",
      :from => "From",
      :type => "Type",
      :conversation_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/From/)
    rendered.should match(/Type/)
    rendered.should match(/1/)
  end
end
