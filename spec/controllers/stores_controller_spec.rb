require 'rails_helper'

RSpec.describe StoresController, :type => :controller do

  describe "GET inedex" do
    it "returns http success" do
      get :inedex
      expect(response).to be_success
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show
      expect(response).to be_success
    end
  end

end
