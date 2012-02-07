require "spec_helper"

describe TaskCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/task_categories").should route_to("task_categories#index")
    end

    it "routes to #new" do
      get("/task_categories/new").should route_to("task_categories#new")
    end

    it "routes to #show" do
      get("/task_categories/1").should route_to("task_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/task_categories/1/edit").should route_to("task_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/task_categories").should route_to("task_categories#create")
    end

    it "routes to #update" do
      put("/task_categories/1").should route_to("task_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/task_categories/1").should route_to("task_categories#destroy", :id => "1")
    end

  end
end
