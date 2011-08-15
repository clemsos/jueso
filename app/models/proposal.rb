class Proposal < ActiveRecord::Base
      
  belongs_to :user
  #belongs_to :proptoproj
  has_many :proptoprojs
  has_many :projects, :through => :proptoprojs
  
  
  #validation
  validates_numericality_of :user_id
  validates_presence_of :state
  validates :title, :presence => true, :length => { :maximum => 60 }
  validates :description, :presence => true
  validates :rewards, :presence => true
  validates :more, :presence => true
  validates_numericality_of :money
  
  #categories
  acts_as_taggable_on :categories
  
  #scopes
  default_scope :order => 'proposals.created_at DESC'
  scope :approved, where(:state => 'approved')
  scope :rejected, where(:state => 'rejected')
  scope :pending, where(:state => 'pending')
    
  #categories
  # acts_as_taggable_on :keywords

  # workflow  
  state_machine :initial => :pending do 
    
    after_transition :on => :approve, :do => :accept_proposal
    after_transition :on => :to_improve, :do => :send_improve_email
    after_transition :on => :reject, :do => :send_reject_email
        
    state :pending, :approved, :rejected, :to_improve

    event :approve do
      transition [:pending, :to_improve] => :approved
    end

    event :reject do
      transition [:pending, :to_improve] => :rejected
    end

    event :to_improve do
      transition :pending => :to_improve
    end
    
  end 
  
  def accept_proposal
    ProposalsMailer::deliver_accept_email(self)
    Project.create
  end
  
  def send_improve_email
    ProposalsMailer::deliver_improve_email(self)  
  end
  
  def send_reject_email
    ProposalsMailer::deliver_reject_email(self)  
  end
  
end
