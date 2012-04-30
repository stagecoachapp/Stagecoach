require 'spec_helper'

describe "messages/new" do
  before(:each) do
    assign(:message, stub_model(Message,
      :text => "MyText",
      :from => "MyString",
      :type => "",
      :conversation_id => 1
    ).as_new_record)
  end

  it "renders new message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path, :method => "post" do
      assert_select "textarea#message_text", :name => "message[text]"
      assert_select "input#message_from", :name => "message[from]"
      assert_select "input#message_type", :name => "message[type]"
      assert_select "input#message_conversation_id", :name => "message[conversation_id]"
    end
  end
end
