require 'rails_helper'

RSpec.describe PagesController, :type => :controller do
  render_views
  describe "GET home" do
    it "returns http success" do
      get :home
      expect(response).to be_success
    end
    
    it "should have the right title" do
      get :home
      expect(response.body).to have_title("Home")
    end
    
    it "should have non-blank body" do
      get :home
      expect(response.body).not_to match(/<body>\s*<\/body>/)
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
  
  describe "GET About" do
    it "returns http success" do
      get :about
      expect(response).to be_success
    end

    it "should return proper title" do
      get :about
      expect(response.body).to have_title("About")
    end
  end

end
