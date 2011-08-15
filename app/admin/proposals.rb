ActiveAdmin.register Proposal do  
  
    scope :all, :default => true
    scope :pending
    scope :approved
    scope :rejected  
  
  index do
    column "ID", :id
    
    column "Title" do |proposal|
        link_to proposal.title, admin_proposal_path(proposal)
    end
    column "Description", :description
    
    column "Author" do |proposal|
        link_to proposal.user_id, admin_user_path(proposal.user_id)
    end    
    
    column "Categories", :category_list
    
    column "Status", :sortable => :state do |proposal| 
      status_tag proposal.state 
    end

    column "Amount", :sortable => :money do |proposal|
      number_to_currency proposal.money
    end
    column "Date", :updated_at
    
    default_actions
  end

  show do

    render 'show'
    
  end

end