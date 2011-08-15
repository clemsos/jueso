ActiveAdmin.register User do
  #sections
  scope :all, :default => true
  
  filter :username
  filter :role
  filter :email
  filter :city
  filter :bio
  filter :weibo
  filter :alias
  
  index do
    id_column
    column "Avatar" do |user| 
       if user.avatar.exists? then 
  			 image_tag user.avatar.url(:medium), :size => "50x50"
  		 else 
  			 image_tag "/images/avatar-default.png", :size => "50x50"
  		 end 
    end
    
    column "Username" do |user|
        link_to user.username, admin_user_path(user)
    end

    column "Role", :role
    column "Email", :email
    
    column "Projects" do |user|
      @user_id = user.id
      @projects = Project.find(
        :all,
        :conditions => [ "user_id = ?", @user_id ]
      )
      
        if @projects.empty?
          '0'
        else
          link_to @projects.count, admin_user_projects_path(user)
        end 
    end
    
    column "Last Visit", :last_sign_in_at
    column "Creation Date", :created_at
    column "Comfirmed", :confirmed_at
    default_actions
  end
  
end
