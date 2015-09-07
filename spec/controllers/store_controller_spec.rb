require 'spec_helper'

describe StoreController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show_product'" do
    it "returns http success" do
      get 'show_product'
      response.should be_success
    end
  end

  describe "GET 'show_order'" do
    it "returns http success" do
      get 'show_order'
      response.should be_success
    end
  end

  describe "GET 'show_cart'" do
    it "returns http success" do
      get 'show_cart'
      response.should be_success
    end
  end

  describe "GET 'share'" do
    it "returns http success" do
      get 'share'
      response.should be_success
    end
  end

end
