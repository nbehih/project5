require 'spec_helper'

describe "Hosts" do
  
  describe "signup" do


  describe "failure" do

        it "should not make a new host" do
          lambda do
          visit signup_path
          fill_in "First name",         :with => ""
          fill_in "last name",        :with => ""
          fill_in "email",        :with => ""
          fill_in "username",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Password Confirmation", :with => ""
          click_button
          response.should render_template('hosts/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Host, :count)
      end
    end
     describe "success" do

      it "should not make a new host" do
        lambda do
        visit signup_path
        fill_in "first",         :with => "Nawal"
        fill_in "last",        :with => "Behih"
        fill_in "email",        :with => "nabehih@gmail.com"
        fill_in "username",        :with => "nabehih"
        fill_in "Password",     :with => "coucou123"
        fill_in "Password Confirmation", :with => "coucou123"
        click_button
        response.should have_selector("div.flash.success", :content => "Welcome")
        response.should render_template('hosts/show')
      end.should change(Host, :count).by(1)
    end
  end
end
describe "signin" do
    
    describe "failure" do
      it "should not sign a host in" do
        visit signin_path
        fill_in "Email", :with => ""
        fill_in "Password", :with => ""
        click_button
        response.should have_selector('div.flash.error',
                                      :content => "Invalid")
        response.should render_template('sessions/new')
      end
    end
    
    describe "success" do
      it "should sign a host in and out" do
        host = FactoryGirl.create(:host)
        visit signin_path
        fill_in "Email", :with => host.email
        fill_in "Password", :with => host.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end