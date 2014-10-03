require 'rails_helper'

RSpec.describe "FriendlyForwardings", :type => :request do

  describe "GET /friendly_forwardings" do
    it "should forward to the requested page after sign" do
      user = Factory(:user)
      visit edit_user_path(user)
      fill_in :email,    :with => user.email
      fill_in :password, :with => user.password
      click_button
      expect(response).to render_template('users/edit')
      visit signout_path
      visit signin_path
      fill_in :email,   :with => user.email
      fill_in :password,:with => user.password
      click_button
      expect(response).to render_template('users/show')
    end
  end

end
