require 'spec_helper'

describe "task_categories/new" do
  before(:each) do
    assign(:task_category, stub_model(TaskCategory,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new task_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => task_categories_path, :method => "post" do
      assert_select "input#task_category_name", :name => "task_category[name]"
    end
  end
end
