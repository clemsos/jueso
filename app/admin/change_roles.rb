ActiveAdmin.register ChangeRole do
  menu :parent => 'Users'
  
  
  scope :all
  scope :approved
  scope :rejected
  scope :pending, :default => true

  
  index do
     column "ID", :id
     column "Role", :role
     column "Real Name", :real_name
     column "User Profile" do |changerole| 
          link_to User.where(:id => changerole.user_id).first.username, admin_user_path(changerole.user_id)
     end
     column "Phone", :phone
     column "Email" do |changerole| 
       User.where(:id => changerole.user_id).first.email
     end
     column "City" do |changerole| 
       User.where(:id => changerole.user_id).first.city
     end
     column "Status", :sortable => :state do |proposal| 
       status_tag proposal.state 
     end
     default_actions
     
  end
  
  show do
     render 'show'
  end
  
  form :partial => "form"

  
end
