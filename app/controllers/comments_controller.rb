class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  

  def edit
    @comment = comment.find(params[:id])
  end


  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(params[:comment])
    @comment.user_id = current_user.id
  #  @comment.project_id = @project
    
    respond_to do |format|
      if @comment.save
        format.js { render '/projects/comment'}
      end  
    end
  end
  
end