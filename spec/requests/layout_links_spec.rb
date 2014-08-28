require 'rails_helper'

RSpec.describe "LayoutLinks", :type => :request do
  describe "GET /layout_links" do
    it "should have a Home page at root_page" do
      visit root_path
      expect(page).to have_title("Home")
    end
    
    it "should have a Contact page at contact_path" do
      visit contact_path
      expect(page).to have_title("Contact")
    end

    it "should have a Help page at help_path" do
      visit help_path
      expect(page).to have_title("Help")
    end
    
    it "should have a About page at about_path" do
      visit about_path
      expect(page).to have_title("About")
    end

    it "should have a sign up page at /signup" do
      visit signup_path
      expect(page).to have_title("Sign up")
    end

    it "should have right links on the layout" do
      visit root_path
      expect(page).to have_title("Home")
      click_link "About"
      expect(page).to have_title("About")
      click_link "Contact"
      expect(page).to have_title("Contact")
      click_link "Home"
      expect(page).to have_title("Home")
      click_link "Sign up now!"
      expect(page).to have_title("Sign up")
      expect(page).to have_selector('a[href="/"]>img')
    end
  end
end
