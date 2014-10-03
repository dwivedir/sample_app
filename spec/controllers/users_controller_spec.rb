require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  render_views

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show, :id => @user
      expect(response).to be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get :show, :id => @user
      expect(response.body).to have_title(@user.name)
    end

    it "should have the user's name" do
      get :show, :id => @user
      expect(response.body).to have_selector('h1', :content => @user.name)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
   
    it "should have the right title" do
      get :new
      expect(response.body).to have_title("Sign up")
    end
  end

  describe "GET 'edit' " do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      expect(response).to be_success
    end

    it "should have the right title" do
      get :edit, :id => @user
      expect(response.body).to have_title("Edit user")
    end

    it "should have a link to change the Gravatar" do
      get :edit, :id => @user
      expect(response.body).to have_selector('a', :href => 'http://gravatar.com/emails',
                                                   :content => "change")
    end

  end

  describe " PUT 'update' " do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe  "failure" do
      
      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should render the edit page " do
        put :update, :id => @user, :user => @attr
        expect(response).to render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        expect(response.body).to have_title("Edit User")
      end

    endu

    describe "success" do

      before(:each) do
        @attr = { :name => "New Name", :email => "user@example.org",                             :password => "barbaz", :password_confirmation => "barbaz" }
      end

      it "should change the user's attributes " do
        put :update, :id => @user, :user => @attr
        user = assigns(:user)
        @user.reload
        expect(@user.name).to eq(user.name)
        expect(@user.email).to eq(user.email)
      end

      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        expect(flash[:success]).to match(/updated/)
      end

    end
  end

  describe "authentication of edit/update actions" do

    before(:each) do
      @user = Factory(:user)
    end

    it "should deny access to 'edit' " do
      get :edit, :id => @user
      expect(response).to redirect_to(signin_path)
      expect(flash[:notice]).to match(/Sign in/i)
    end

    it "should deny access to 'edit' " do
      put :update, :id => @user, :user => {}
      expect(response).to redirect_to(signin_path)
    end

  end
end
