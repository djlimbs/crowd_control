require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'djs'" do
    it "returns http success" do
      get 'djs'
      response.should be_success
    end
  end

  describe "GET 'guests'" do
    it "returns http success" do
      get 'guests'
      response.should be_success
    end
  end

  describe "GET 'couples'" do
    it "returns http success" do
      get 'couples'
      response.should be_success
    end
  end

end
