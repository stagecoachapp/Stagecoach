require 'spec_helper'

describe "task_categories/show" do
  before(:each) do
    @task_category = assign(:task_category, stub_model(TaskCategory,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
