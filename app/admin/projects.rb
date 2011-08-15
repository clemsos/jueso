ActiveAdmin.register Project do  
  
#  belongs_to :user, :optional => true
  
  #scopes
  scope_to do
      Class.new do
        def self.projects
          Project.unscoped
        end
      end
    end
  
  scope :all
  scope :published, :default => true
  scope :unpublished
  scope :funded
  scope :expired
  
  filter :title
  filter :description
  filter :money
  filter :deadline
    
  index do

    id_column
    
    column "Title" do |project|
        link_to project.title, admin_project_path(project)
    end
    column 'Author' do |project|
      link_to project.user.username, admin_user_path(project.user)
    end
    
    column "Description"do |project|
     truncate (project.description)
    end
  
    column "Deadline"do |project|
      if project.state != 'expired'
        time_ago_in_words(project.description)
      else
        status_tag 'expired'
      end
    end
    
    column "Comments" do |project|
      @comments = Comment.find( :all, :conditions => [ "project_id = ?", project.id ] )
        if @comments.empty?
          '0'
        else
          link_to @comments.count, admin_project_user_comments_path(project)
        end
    end
    
    column "Updates" do |project|
      @updates = Update.find( :all, :conditions => [ "project_id = ?", project.id ] )
        if @updates.empty?
          '0'
        else
          link_to @updates.count, admin_project_updates_path(project)
        end
    end
    
    column "Backs" do |project|
      @backs = Back.find( :all, :conditions => [ "project_id = ?", project.id ] )
        if @backs.empty?
          '0'
        else
          link_to @backs.count, admin_project_backs_path(project)
        end
    end
    
    column "Money", :sortable => :total do |project|
      number_to_currency project.total
    end
    
    column "Objective", :sortable => :money do |project|
      number_to_currency project.money
    end
    
    column "Status", :sortable => :state do |project| 
      status_tag project.state 
    end
    
    # column "Created", :created_at
    default_actions
  end
  
  show do 
    status_tag project.state
    render 'show'
  end
    
    
end
