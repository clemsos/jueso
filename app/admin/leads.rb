ActiveAdmin.register Lead do
    menu :parent => 'Home', :label => 'Featured projects'
    
  index :as => :grid, :columns => 3 do |lead|
      link_to(image_tag(lead.featimage.url, :width => "300px"), admin_lead_path(lead))
  end
    
    
  form :html => { :enctype => "multipart/form-data" } do |f|
    
    f.inputs "lead", :multipart => true do      

      f.input :title
      f.input :featimage
      
    #  if params[:action] == "edit"
    #    if (f.thumbnail.exists?) then
    #      image_tag f.thumbnail.url()
    #    end
    #  end

    end
    f.inputs "Project" do
    	f.collection_select :project_id, Project.all, :id.to_s, :title, :include_blank => true
    end    
    f.buttons
  end
  

  
end
