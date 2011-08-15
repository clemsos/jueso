class BacksController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  
  def new
    @project = Project.find(params[:project_id])
    @back = Back.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @back = Back.find(params[:id])
  end


  def create
    @project = Project.find(params[:project_id])
    @back = @project.backs.build(params[:back])
    @back.user_id = current_user.id
    
    # @back.project_id

    respond_to do |format|
      if @back.save
         format.html { redirect_to(@project) }
         format.xml  { render :xml => @project, :status => :created, :location => @project }
         flash[:success] = "Thanks!"
         
         if (@project.state == 'published' && @project.total > @project.money)
             @project.fund_raised!
         end
         
         
      else
        flash[:error] = "Oops error!"
        format.html {redirect_to(project_back_path(@project))}
      end
    end
  end
  
end
