require 'rails_helper'

RSpec.describe User, :type => :model do
 
  before(:each) do
    @attr = { :name => "Example user", :email => "user@example.com"}
  end 
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    expect(no_name_user).not_to be_valid
  end

  it "should require an email address " do
    no_email_user = User.new(@attr.merge(:email => ""))
    expect(no_email_user).not_to be_valid
  end

  it "should reject names that are too long" do
     long_name = "a" * 51
     long_name_user = User.new(@attr.merge(:name => long_name))
     expect(long_name_user).not_to be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      expect(valid_email_user).to be_valid
    end
  end

  it "should reject invalid addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      expect(valid_email_user).not_to be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end

  it "should reject email addresses indentical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end
end
