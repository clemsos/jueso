class Back < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_numericality_of :amount  
  validates_numericality_of :user_id
  validates_numericality_of :project_id

  attr_accessible :amount, :comment
  
  default_scope :order => 'backs.created_at DESC'
  
  include Notifications
  after_create :notify
    
  private
    def notify
      self.create_notifications(self.user_id, self.class.name, self.project_id)  
    end

    
end