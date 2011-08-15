ActiveAdmin.register Comment, :as => 'User Comments' do
      menu :label => 'Comments'
      belongs_to :project, :optional => true
      
      
      index do        
        id_column
        
        column "Project" do |comment|
          link_to comment.project.title, admin_project_path(comment.project)
        end
        
        column "User" do |comment|
          link_to comment.user.username, admin_user_path(comment.user)
        end

        column "Body", :body
        column "Created_at", :created_at

        default_actions

       end
      
      
end
