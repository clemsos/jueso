class FavoritesController < ApplicationController
  before_filter :authenticate_user!
  
  #load_and_authorize_resource


  def create
    @project = Project.find(params[:favorite][:project_id])
    current_user.favorable!(@project)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @project = Favorite.find(params[:id]).project
    current_user.unfavorable!(@project)
      respond_to do |format|
        format.js
      end
  end
    
end