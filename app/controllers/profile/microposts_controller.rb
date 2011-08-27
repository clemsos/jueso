class Profile::MicropostsController < ProfileController
  before_filter :authenticate_user!, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  

  def create
      @micropost  = current_user.microposts.build(params[:micropost])
      @user = current_user
      @feed_items = current_user.feed.page params[:page]
      @projects = current_user.projects.all
      @proposals = current_user.proposals.all
      
      if @micropost.save
        flash[:success] = "Status updated!"
        render 'profile/home'
      else
        @feed_items = []
        render 'profile/home'
      end
  end


  
  private
  
    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end

end

