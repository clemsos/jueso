require 'spec_helper'

describe User do
  
  before(:each) do
     @attr = { :password => "password00", :email => "user@example.com" }
   end


describe "relationships" do

    before(:each) do
      @user = User.create!(@attr)      
      @followed = Factory(:user)
    end

    it "should have a relationships method" do
      @user.should respond_to(:relationships)
    end
    
    it "should have a following method" do 
      @user.should respond_to(:following)
    end
    
    it "should have a following? method" do
      @user.should respond_to(:following?)
    end
    
    it "should have a follow! method" do 
      @user.should respond_to(:follow!)
    end
    
    it "should follow another user" do 
      @user.follow!(@followed) 
      @user.should be_following(@followed)
    end 
    
    it "should include the followed user in the following array" do
      @user.follow!(@followed)
      @user.following.should include(@followed) 
    end
    
    it "should have an unfollow! method" do
      @followed.should respond_to(:unfollow!)
    end 
    
    it "should unfollow a user" do
      @user.follow!(@followed)
      @user.unfollow!(@followed)
      @user.should_not be_following(@followed)
    end
    
    #follower
    it "should have a reverse_relationships method" do
      @user.should respond_to(:reverse_relationships)
    end 
    
    it "should have a followers method" do
      @user.should respond_to(:followers)
    end
      
    it "should include the follower in the followers array" do 
      @user.follow!(@followed)
      @followed.followers.should include(@user)
    end
      
      
  end

end