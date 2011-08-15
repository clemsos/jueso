class Profile::GalleriesController <  ProfileController
  
  def new
    @gallery = Gallery.new
  end
  
  def edit
    @gallery = Gallery.find(params[:id])
  end
  
  def show 
      @gallery = Gallery.find(params[:id])
  end
  
  def index
      @galleries = current_user.galleries.all
  end
  
  def create
    @gallery = Gallery.new(params[:gallery])
    @gallery.user_id = current_user.id
    
   respond_to do |format|
      if @gallery.save
        format.html {redirect_to(profile_gallery_path(@gallery), :notice => 'Gallery was successfully created.') }
        format.xml  { render :xml => profile_gallery_path(@gallery), :status => :created, :location => @gallery }
      else
       format.html { render :action => "new" }
      format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
     end
    end
  end
  
  
  def add_files
      @gallery = Gallery.find(params[:gallery_id])
      @upload  = Upload.new
      @uploads = @gallery.uploads.all
  end
  
  
  def update
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        format.html { redirect_to(profile_gallery_path(@gallery), :notice => 'gallery was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gallerys/1
  # DELETE /gallerys/1.xml
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to(gallerys_url) }
      format.xml  { head :ok }
    end
  end
end