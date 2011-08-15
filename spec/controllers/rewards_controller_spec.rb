require 'spec_helper'

describe RewardsController do

  describe "GET 'amount_min:number'" do
    it "should be successful" do
      get 'amount_min:number'
      response.should be_success
    end
  end

  describe "GET 'amount_max:number'" do
    it "should be successful" do
      get 'amount_max:number'
      response.should be_success
    end
  end

  describe "GET 'description:text'" do
    it "should be successful" do
      get 'description:text'
      response.should be_success
    end
  end

end
