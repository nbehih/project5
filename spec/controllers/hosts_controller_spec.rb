require 'spec_helper'

describe HostsController do
render_views
describe "GET 'show'" do

    before(:each) do
      @host = Factory(:host)
    end

    it "should be successful" do
      get :show, :id => @host
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @host
      assigns(:host).should == @host
    end
        it "should have the right title" do
      get :show, :id => @host
      response.should have_selector("title", :content => @host.first_name)
    end
    it "should have a profile image" do
      get :show, :id => @host
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
     it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end

end
