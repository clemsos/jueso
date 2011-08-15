class GalleriesController < ApplicationController
  
  layout 'portfolio'
    
  def portfolio
    @user = User.where(:alias => params[:alias]).first
  #  @user = User.find(params[:user_id])
    @title = @user.username+ "'s porfolio"
  end
  
  def show
    @user = User.find(params[:user_id])
    @gallery = Gallery.find(params[:id])
    @title = @gallery.title
  end
  
end