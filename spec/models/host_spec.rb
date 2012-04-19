require 'spec_helper'

describe Host do

  before(:each) do
    @attr = { :first_name => "Example", :last_name => "User", :email => "user@example.com", :username => "user" }
  end

  it "should create a new instance given valid attributes" do
    Host.create!(@attr)
  end

  
   it "should require a first_name" do
    no_first_name_host = Host.new(@attr.merge(:first_name => ""))
    no_first_name_host.should_not be_valid
  end
     it "should require a last_name" do
    no_last_name_host = Host.new(@attr.merge(:last_name => ""))
    no_last_name_host.should_not be_valid
  end
  it "should require an email address" do
    no_email_host = Host.new(@attr.merge(:email => ""))
    no_email_host.should_not be_valid
  end
  it "should require a username" do
    no_username_host = Host.new(@attr.merge(:username => ""))
    no_username_host.should_not be_valid
  end
  it "should reject first names that are too long" do
    long_first_name = "a" * 51
    long_first_name_host = Host.new(@attr.merge(:first_name => long_first_name))
    long_first_name_host.should_not be_valid
  end
  it "should reject last names that are too long" do
    long_last_name = "a" * 51
    long_last_name_host = Host.new(@attr.merge(:last_name => long_last_name))
    long_last_name_host.should_not be_valid
  end
  it "should reject usernames that are too long" do
    long_username = "a" * 51
    long_username_host = Host.new(@attr.merge(:username => long_username))
    long_username_host.should_not be_valid
  end
    it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_host = Host.new(@attr.merge(:email => address))
      valid_email_host.should be_valid
    end
  end
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_host = Host.new(@attr.merge(:email => address))
      invalid_email_host.should_not be_valid
    end
  end
   it "should reject duplicate email addresses" do
    Host.create!(@attr)
    host_with_duplicate_email = Host.new(@attr)
    host_with_duplicate_email.should_not be_valid
  end
   it "should reject duplicate first name" do
    Host.create!(@attr)
    host_with_duplicate_firstName = Host.new(@attr)
    host_with_duplicate_firstName.should_not be_valid
  end
     it "should reject duplicate last name" do
    Host.create!(@attr)
    host_with_duplicate_lastName = Host.new(@attr)
    host_with_duplicate_lastName.should_not be_valid
  end
    it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Host.create!(@attr.merge(:email => upcased_email))
    host_with_duplicate_email = Host.new(@attr)
    host_with_duplicate_email.should_not be_valid
  end
      
       it "should reject username identical up to case" do
    upcased_username = @attr[:username].upcase
    Host.create!(@attr.merge(:username => upcased_username))
    host_with_duplicate_username = Host.new(@attr)
    host_with_duplicate_username.should_not be_valid
  end
end