require 'spec_helper'

describe User, "when creating user" do 
  
  before :each do
    @new_user = User.new(:name => 'Ryan', :email => 'mcafeeryan92@gmail.com')
  end
  
  it "it should return object of type User" do
    @new_user.should be_an_instance_of User
  end
  
  it "the instance should have the correct name" do
    @new_user.name.should eq('Ryan')
  end
  
  it "it should save to database" do
    @new_user.save()
    User.find(@new_user.id).name.should eq(@new_user.name)
  end
  
  it "it should be able to update a user" do
    @new_user.update_attributes(:name => 'Jon', :email => 'jonton@gmail.com')
    @new_user.save()
    User.find(@new_user.id).name.should eq('Jon')
  end
  
  it "it should be able to delete a user" do
    @new_user.destroy()
    User.should have(0).things
  end
  
end