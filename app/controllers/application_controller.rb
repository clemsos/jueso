class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #before_filter :authenticate_user!
  
  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    deny_access
    # redirect_to login_url
  end
  
  # Customize the Devise after_sign_in_path_for() for redirecct to previous page after login
  def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')  
    if (request.referer == sign_in_url)
      super
    else
      request.referer
    end
  end

  protected
  
  #  def ckeditor_filebrowser_scope(options = {})
  #    super { :assetable_id => current_user.id, :assetable_type => 'User' }.merge(options)
  #  end


  
end