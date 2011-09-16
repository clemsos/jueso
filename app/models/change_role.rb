class ChangeRole < ActiveRecord::Base
  validates_presence_of :real_name, :role 
  belongs_to :user
  attr_accessible :id, :phone, :more, :description, :real_name 
  
  validates :description, :presence => true, :length => { :maximum => 400 } 
  validates :more, :presence => true, :length => { :maximum => 400 }
  validates :phone, :presence => true, :numericality => true
  
  #heritate from user
  acts_as_taggable_on :skills
  
  state_machine :initial => :pending do
      state :pending, :rejected, :approved
      
      after_transition :on => :accept, :do => :change_user_role
      
      event :reject do
        transition :pending => :rejected
      end
      
      event :accept do
        transition [:rejected,:pending] => :approved
      end
  end
  
  scope :approved, where(:state => 'approved')
  scope :rejected, where(:state => 'rejected')
  scope :pending, where(:state => 'pending')
  
  def change_user_role
    r = Role.where(:name => self.role).first.id
    User.where(:id => self.user_id).first.role_ids = [r]
  end

end
