class Update < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  has_attached_file :data,
                    :path => ":rails_root/public/uploads/:class/:id/:basename.:extension",
                    :url => "/uploads/:class/:id/:basename.:extension"
                    
  validates :title, :presence => true
  validates :body, :presence => true
  
  state_machine :initial => :draft do
    state :draft, :published, :trashed
    
    event :publish do
      transition :draft => :published
    end
    
    event :trash do
      transition [:draft,:published] => :trashed
    end
    
    event :draftify do
      transition [:published,:published] => :draft
    end
    
  end
  
end
