require "spec_helper"

describe RemindersController do
  describe "routing" do

    it "routes to #index" do
      get("/reminders").should route_to("reminders#index")
    end

    it "routes to #new" do
      get("/reminders/new").should route_to("reminders#new")
    end

    it "routes to #show" do
      get("/reminders/1").should route_to("reminders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reminders/1/edit").should route_to("reminders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reminders").should route_to("reminders#create")
    end

    it "routes to #update" do
      put("/reminders/1").should route_to("reminders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reminders/1").should route_to("reminders#destroy", :id => "1")
    end

  end
end
