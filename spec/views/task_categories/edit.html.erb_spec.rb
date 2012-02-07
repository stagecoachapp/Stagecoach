require 'spec_helper'

describe "task_categories/edit" do
  before(:each) do
    @task_category = assign(:task_category, stub_model(TaskCategory,
      :name => "MyString"
    ))
  end

  it "renders the edit task_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => task_categories_path(@task_category), :method => "post" do
      assert_select "input#task_category_name", :name => "task_category[name]"
    end
  end
end
