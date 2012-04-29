require 'spec_helper'

describe SessionsController do
	render_views


  describe "GET 'new'" do
    it "rshould be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
    	get :new
    	response.should have_selector("title", :content => "Sign in")
    end
  end
  describe "POST 'create'" do

  	describe "invalid signin" do
  		before(:each) do
  			@attr = {:email => "", :password => "" }
  	end

  	it "should re-render the new page" do
  		post :create, :session => @attr
  		response.should render_template('new')
  	end

  	it "should have the right title" do
  		post :create, :session => @attr
  		response.should  have_selector("title", :content => "Sign in")
	end

	it "should have a flash.now message" do
		post :create, :session => @attr
		flash.now[:error].should =~ /invalid/i
	end
end

  describe "with valid email and password" do
      
      before(:each) do
        @host = FactoryGirl.create(:host)
        @attr = { :email => @host.email, :password => @host.password }
      end

      it "should sign the host in" do
        post :create, :session => @attr
        controller.current_host.should == @host
        controller.should be_signed_in
      end

      it "should redirect to the host show page" do
        post :create, :session => @attr
        response.should redirect_to(host_path(@host))
      end
    end
end
describe "DELETE 'destroy'" do
    it "should sign a host out" do
      test_sign_in(Factory(:host))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end
end