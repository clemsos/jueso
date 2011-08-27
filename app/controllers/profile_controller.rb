class ProfileController < ApplicationController
      before_filter :authenticate_user!
      
  def show
    render :layout => 'profile'
      @user = current_user
  end
  
  def index
    render :layout => 'profile'
      @user = current_user
  end
  
  def home
    @title = "Home"
    @user = current_user
    
    if user_signed_in?
        @micropost = Micropost.new
        @feed_items = current_user.feed.page params[:page]
        @projects = @user.projects.all
        @proposals = @user.proposals.all
    end
    
  end
  
  def thanks
    
  end
  

end