class Favorite < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_numericality_of :user_id
  validates_numericality_of :project_id
  
  default_scope :order => 'favorites.created_at DESC'
  
  include Notifications
  after_create :notify
  
  private 
    def notify
      self.create_notifications(self.user_id, self.class.name, self.project_id)  
    end

end
