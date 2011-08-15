class GalleriesFilesController < ApplicationController
  before_filter :authenticate_user!

  def create
    # @project = Project.find(params[:id])
    @gallery = Gallery.find(params[:gallery_id])
    @gallery.addfile!(@upload)
  end