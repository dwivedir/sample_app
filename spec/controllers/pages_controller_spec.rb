require 'rails_helper'

RSpec.describe PagesController, :type => :controller do
  render_views
  describe "GET home" do
    it "returns http success" do
      get :home
      expect(response).to be_success
    end
    
    it "return proper title" do
      get :home
      expect(response.body).to have_title("Home")
    end
  end

  describe "GET contact" do
    it "returns http success" do
      get :contact
      expect(response).to be_success
    end
    it "should return proper title" do
      get :contact
      expect(response.body).to have_title("Contact")
    end
  end
  

end
