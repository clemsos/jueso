require 'spec_helper'

describe MicropostsController do
  
  
  describe "micropost associations" do

      before(:each) do
        @user = Factory(:user)
        @mp1 = Factory(:micropost, :user => @user, :created_at => 1.day.ago)
        @mp2 = Factory(:micropost, :user => @user, :created_at => 1.hour.ago)
      end

      describe "status feed" do

        it "should have a feed" do
          @user.should respond_to(:feed)
        end

        it "should include the user's microposts" do
          @user.feed.include?(@mp1).should be_true
          @user.feed.include?(@mp2).should be_true
        end

        it "should not include a different user's microposts" do
          mp3 = Factory(:micropost,
                        :user => Factory(:user, :email => Factory.next(:email)))
          @user.feed.include?(mp3).should be_false
        end
      end
    end
  
  

  describe "POST 'create'" do
    render_views
    
    before(:each) do
	    # Create the user object by factory
	    @user = Factory(:user)
	    # Sign in the yser
	    test_sign_in(@user)
    end


    describe "failure" do

      before(:each) do
        @attr = { :content => "" }
      end
      
      it "should not create a micropost" do
        lambda do
          post :create, :micropost => @attr
        end.should_not change(Micropost, :count)
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end

      it "should create a micropost" do
        lambda do
          post :create, :micropost => @attr
        end.should change(Micropost, :count).by(1)
      end
    end
  end
  
  describe "DELETE 'destroy'" do

      describe "for an unauthorized user" do

        before(:each) do
          @user = Factory(:user)
          wrong_user = Factory(:user, :email => "blabla@blabl.com")
          test_sign_in(wrong_user)
          @micropost = Factory(:micropost, :user => @user)
        end

        it "should deny access" do
          delete :destroy, :id => @micropost
          response.should redirect_to(root_path)
        end
      end

      describe "for an authorized user" do

        before(:each) do
          @user = test_sign_in(Factory(:user))
          @micropost = Factory(:micropost, :user => @user)
        end

        it "should destroy the micropost" do
          lambda do 
            delete :destroy, :id => @micropost
          end.should change(Micropost, :count).by(-1)
        end
      end
    end
  
end
