require 'spec_helper'

describe PagesController do
  
  describe "GET 'home'" do
    
    describe "when signed in" do
      before(:each) do 
        @user = test_sign_in(Factory(:user)) 
        other_user = Factory(:user, :email => Factory.next(:email)) 
        other_user.follow!(@user)
      end
  
  end
end 

end
