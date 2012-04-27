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
        fill_in "Confirmation", :with => "coucou123"
        click_button
        response.should have_selector("div.flash.success", :content => "Welcome")
        response.should render_template('hosts/new')
      end.should change(Host, :count).by(1)
    end
  end
end