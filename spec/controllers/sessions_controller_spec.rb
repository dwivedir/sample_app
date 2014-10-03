require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  render_views
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end

    it "should have the right title" do
      get :new
      expect(response.body).to have_title("Sign in")
    end 
  end

  describe "POST 'create' " do

    describe "failure" do

      before(:each) do
        @attr = { :email => "", :password => "" }
      end

      it "should re-render the new page" do
        post :create, :session => @attr
        expect(response).to render_template('new')
      end

      it "should have an error message" do
        post :create, :session => @attr
        expect(flash.now[:error]).to match(/invalid/i)
      end

      it "should have the right title" do
        post :create, :session => @attr
        expect(response.body).to have_title("Sign in")
      end

end
