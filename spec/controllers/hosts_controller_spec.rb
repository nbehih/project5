require 'spec_helper'

describe HostsController do
render_views

  describe "GET 'index'" do

    describe "for non-signed-in hostss" do
      it "should deny access" do
        get :index
        redirect_to signin_path, :notice => "Please sign in to access this page."
      end
    end
    
    describe "for signed-in-hostss" do

       before(:each) do
          @host = Factory(:host)
          test_sign_in(@host)
          second = Factory(:host, :first_name => "Bob", :email => "another@example.com")
          third  = Factory(:host, :first_name => "Ben", :email => "another@example.net")

          
          @hosts = [@host, second, third]
                  30.times do
                    @hosts << Factory(:host, :first_name => Factory.next(:first_name),
                                             :email => Factory.next(:email))
        end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should have the right title" do
        get :index
        response.should have_selector('title', :content => "All users")
      end
    end
  end
describe "GET 'show'" do

    before(:each) do
      @host = Factory(:host)
    end

    it "should be successful" do
      get :show, :id => @host
      response.should be_success
    end

    it "should find the right host" do
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
    it "should have the host's name" do
      get :show, :id => @host
      response.should have_selector('h1', :content => @host.first_name)
    end

describe "when signed in as another host" do
      it "should be successful" do
        test_sign_in(FactoryGirl.create(:host, :email => Factory.next(:email)))
        get :show, :id => @host
        response.should be_success
      end
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

describe "POST 'create'" do

    describe "failure" do
      
      before(:each) do
        @attr = { :first_name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end
      
      it "should have the right title" do
        post :create, :host => @attr
        response.should have_selector('title', :content => "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :host => @attr
        response.should render_template('new')
      end

      it "should not create a host" do
        lambda do
          post :create, :host => @attr
        end.should_not change(Host, :count)
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :first_name => "New Host", :email => "host@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create a host" do
        lambda do
          post :create, :host => @attr
        end.should change(Host, :count).by(1)
      end
      
      it "should redirect to the host show page" do
        post :create, :host => @attr
        response.should redirect_to(host_path(assigns(:host)))
      end

      it "should sign the host in" do
        post :create, :host => @attr
        controller.should be_signed_in
      end
 end
end
end
end
