class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :update, :destroy, :passchange]
   
  
  # GET /users
  # GET /users.xml
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  

    def show
      @user = User.find(params[:id])
      @microposts = @user.microposts.paginate(:page => params[:page])
      @projects = @user.projects.paginate(:page => params[:page])
      @backs = @user.backs.paginate(:page => params[:page])
            
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user }
      end
    end

    # GET /users/new
    # GET /users/new.xml
    def new
      @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @user }
      end
    end

    # GET /users/1/edit
    def edit
      @user = User.find(params[:id])
    end

    # POST /users
    # POST /users.xml
    def create
      @user = User.new(params[:user])
       
      respond_to do |format|
        if @user.save
          if params[:user][:avatar].blank?
            format.html { redirect_to(@user, :notice => 'User was successfully created.') }
          else
            @user = current_user
            @user.avatar = current_picture
            render :json => { :pic_path => @user.avatar.url.to_s, :name => @user.avatar.instance.attributes["picture_file_name"] }, :content_type => 'text/html'
          end
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /users/1
    # PUT /users/1.xml
    def update
      @user = User.find(params[:id])
      respond_to do |format|
        if @user.update_attributes(params[:user])
          if params[:user][:avatar].blank?
                format.html { render :action => "edit"}
          else
              format.js { render :action => "show_crop"}
          end
        else
          format.html { render :action => "edit" }
        end
      end
    end

    # DELETE /users/1
    # DELETE /users/1.xml
    def destroy
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    end
    
    def following
        @title = "Following"
        @user = User.find(params[:id])
        @users = @user.following.paginate(:page => params[:page])
        render 'show_follow'
    end

    def followers
      @title = "Followers"
      @user = User.find(params[:id])
      @users = @user.followers.paginate(:page => params[:page])
      render 'show_follow'
    end
    
    
    def profile
      @title = "Home"
      @user = current_user
      
      if user_signed_in?
          @micropost = Micropost.new
          @feed_items = current_user.feed.paginate(:page => params[:page])
          @projects = @user.projects.all
          @proposals = @user.proposals.all
      end
    end
    
    
    def passchange
         @user = current_user
         respond_to do |format|
           format.js
         end
    end
    
    
    def avatar
        @user = current_user
       respond_to do |format|
         format.js
       end
    end
    
    
    def show_pic
      @user.avatar = current_picture
      geo = Paperclip::Geometry.from_file(@user.avatar.to_file(:original))
      @adapter = geo.width > User::MAX_CROP_WIDTH.to_f ? geo.width/User::MAX_CROP_WIDTH.to_f : 1
      @width = geo.width
      @height = geo.height
      render :json => { :pic_path => @user.avatar.url.to_s }, :content_type => 'text/html'
    end
    
    def show_crop
        @user = current_user
        @avatar = current_picture
        geo = Paperclip::Geometry.from_file(@user.avatar.to_file(:original))
        @adapter = geo.width > Upload::MAX_CROP_WIDTH.to_f ? geo.width/Upload::MAX_CROP_WIDTH.to_f : 1
        @width = geo.width
        @height = geo.height
    end
    
    def current_picture
      current_user.avatar
    end
    
    def before_save
       if @delete_avatar == 1.to_s 
         self.avatar.queued_for_write.clear
         self.avatar = nil 
       end
     end
    
    
    def projects
      @user = User.find(params[:user_id])
      @projects = @user.projects.all
      respond_to do |format|
         format.js
       end
    end

    def favorites
      @user = User.find(params[:user_id])
      @projects = @user.favorite_projects.find(:all)
      respond_to do |format|
         format.js
       end
    end
    
    def backs
      @user = User.find(params[:user_id])
      @projects = @user.backed_projects.find(:all, :group => 'project_id')
      respond_to do |format|
         format.js
       end
    end
end