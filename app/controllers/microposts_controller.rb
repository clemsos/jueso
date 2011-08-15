class MicropostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.js
    end
  end
  
  private
  
    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end

end

