require 'spec_helper'

describe Signup, "when creating signup" do 
  before :each do
    @new_signup = Signup.new(:name => 'Ryan', :email => 'mcafeeryan92@gmail.com')
  end
  
  it "it should return object of type Signup" do
    @new_signup.should be_an_instance_of Signup
  end
  
  it "the instance should have the correct name" do
    @new_signup.name.should eq('Ryan')
  end
  
  it "it should save to database" do
    @new_signup.save()
    Signup.find(@new_signup.id).name.should eq(@new_signup.name)
  end
  
  it "it should be able to update a user" do
    @new_signup.update_attributes(:name => 'Jon', :email => 'jonton@gmail.com')
    @new_signup.save()
    Signup.find(@new_signup.id).name.should eq('Jon')
  end
  
  it "it should be able to delete a user" do
    @new_signup.destroy()
    Signup.should have(0).things
  end
  
end