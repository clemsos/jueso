class Profile::ChangeRolesController < ProfileController
  
  def new
    @changerole = ChangeRole.new
  end
  
  
  def create
    @changerole = ChangeRole.new(params[:change_role])
    @changerole.user_id = current_user.id
    
    respond_to do |format|
      
      if @changerole.save
       format.html { redirect_to '/profile/thanks' }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def show
    @changerole = ChangeRole.where(:user_id => current_user.id).first
  end
    
end