class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :only =>[:create, :update]
  
  # GET /projects
  # GET /projects.xml
  respond_to :html, :js
  def index
  	last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
  	@projects = Project.feed(last)
  end
  
  def category
    @projects = Project.tagged_with(params[:id])
     render :index
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    @total = @project.total
    @back = Comment.new(params[:back])
    @comments = @project.comments.paginate(:page => params[:page])
    
    # authorize! :show, @project
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end
  
  def backs
    #@back = Back.new(params[:back])
    @backs = Project.find(params[:project_id]).backs.paginate(:page => params[:page])
    respond_to do |format|
       format.js
     end
  end
  
  def comments
    @project = Project.find(params[:project_id])
    @comment = Comment.new(params[:back])
    @comments = Project.find(params[:project_id]).comments.paginate(:page => params[:page])
    
    respond_to do |format|
       format.js
     end
  end

  def description
    @project = Project.find(params[:project_id])
    respond_to do |format|
       format.js
     end
  end

  def update
    @project = Project.find(params[:project_id])
    @update  = Update.new(params[:update])
    respond_to do |format|
       format.js
     end
  end
  
  def updates
    @updates = Project.find(params[:project_id]).updates.where(:state => 'published').all
    respond_to do |format|
       format.js
     end
  end


  def create
    # create project
    @project = Project.new(params[:project])
    @project.user_id = current_user.id
    
    #pre-populate with proposal id
    @proposal = Proposal.find(params[:proposal_id])
    @project.money = @proposal.money
    @project.title = @proposal.title
    @project.category_list = @proposal.category_list
      
    respond_to do |format|
      if @project.save
        
        #add project-propal relationship table
        @project.transform!(@proposal)
        
        format.html { redirect_to profile_project_path(@project), :notice => 'Project was successfully created.' }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
end

