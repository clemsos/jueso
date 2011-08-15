ActiveAdmin::Dashboards.build do


  # == Proposals
   section "Latest Proposals", :priority => 1 do
     table_for Proposal.order('id desc').limit(10).each do |proposal|
        column(:title) {|proposal| link_to(proposal.title, admin_proposal_path(proposal)) }
        column(:status) {|proposal| status_tag proposal.state }
        column(:author) {|proposal| link_to(proposal.user.username, admin_user_path(proposal.user)) }
     end
   end
  
   # == Members request to change
    section "Members Request", :priority => 1 do
      table_for ChangeRole.order('id desc').limit(10).each do |change_role|
        column(:user) {|change_role| link_to(change_role.user.username, admin_user_path(change_role.user)) }
        column(:role) {|change_role| link_to(change_role.role, admin_change_role_path(change_role)) }
         column(:state) {|change_role| status_tag change_role.state }
 
      end
    end
  
    # == Latest comments
    section "Latest Comments", :priority => 1 do
      table_for Comment.order('id desc').limit(20).each do |comment|
        column(:id) {|comment| link_to(comment.id, admin_user_comment_path(comment)) }
        column(:user) {|comment| link_to(comment.user.username, admin_user_path(comment.user)) }
        column(:body) {|comment|   comment.body }
      end
    end
     

  
  # == Projects
   section "Recent Projects", :priority => 2 do
     table_for Project.order('id desc').limit(10).each do |project|
        column(:title) {|project| link_to(project.title, admin_project_path(project)) }
        column(:status) {|project| status_tag project.state }
        column(:author) {|project| link_to(project.user.username, admin_user_path(project.user)) }
        column(:promote) {|project| link_to("Add to Home", new_admin_lead_path) }
     end
   end
  
  
  # == Featured
  section "Projects Featured on Homepage", :priority => 2 do
    table_for Lead.order('id desc').limit(10).each do |lead|
      # column(:title) {|lead| link_to(lead.title, admin_lead_path(lead)) }
       column(:project) {|lead| link_to(lead.project.title, admin_lead_path(lead)) }
    end
    #link_to('Feature a project', new_admin_lead_path)
  end

  
end
