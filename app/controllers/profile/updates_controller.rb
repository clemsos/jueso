class Profile::UpdatesController <  ProfileController
  before_filter :authenticate_user!

  def new
      @project = Project.find(params[:project_id])
      @update = Update.new
  end
  
    
  def create
    @project = Project.find(params[:project_id])
    @update =  Update.new(params[:update])
    @update.user_id = current_user.id
    @update.project_id = params[:project_id]
    
    respond_to do |format|
      if @update.save
        format.html { redirect_to( profile_project_update_path(@update.project_id,@update) ) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  
  def update
    @update = Update.find(params[:id])
    @project = Project.find(params[:project_id])

    respond_to do |format|
      if @update.update_attributes(params[:update])
        format.html { render :action => "edit", :notice => 'Project was successfully created.' }
      end
    end
  end
  
  
  def edit
    @update = Update.find(params[:id])
    @project = Project.find(params[:project_id])
    
    respond_to do |format|
       format.html
       format.xml  { render :xml => @project }
     end
  end
  
   def show
     @update = Update.find(params[:id])
    @project = Project.find(params[:project_id])
     respond_to do |format|
       format.html # show.html.erb
       format.xml  { render :xml => @project }
     end
   end
   
   def index
     @updates = Update.where(:project_id == params[:project_id]).all
   end
end