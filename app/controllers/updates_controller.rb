class UpdatesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @project = Project.find(params[:project_id])
    @update = @project.updates.build(params[:update])
    @update.user_id = current_user.id
    @update.state = 'published'
    
    respond_to do |format|
      if @update.save
         format.json { render :json => @update }
      end
    end
  end
  
  def edit
    @update = update.find(params[:id])
  end
  
end