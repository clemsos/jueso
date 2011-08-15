ActiveAdmin.register Update do
      #menu :parent => 'Projects'
      belongs_to :project
      
      index do
        id_column
        column :title
        column "Status", :sortable => :body do |update| 
          update.body 
        end
        column :created_at
        column "Status", :sortable => :state do |update| 
          status_tag update.state 
        end
        column "Project", :sortable => :body do |update| 
          link_to update.project.title, admin_project_path(update.project)
        end
        column "User", :sortable => :body do |update| 
          link_to update.user.username, admin_user_path(update.user)
        end
        default_actions
      end
        
end
