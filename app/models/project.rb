class Project < ActiveRecord::Base  
  belongs_to :user
  belongs_to :feature
  
  has_many :proptoprojs
  has_many :proposals, :through => :proptoprojs
  
  has_many :leads, :dependent => :destroy
  
  #content validation
  validates :title, :presence => true, :length => { :maximum => 60 }
  validates :description, :presence => true
  validates :video_link, :presence => true
  validates :money, :presence => true
  validates :deadline, :presence => true
  validates :category_list, :presence => true
    
  #dependencies
  has_many :rewards, :dependent => :destroy
  has_many :backs, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :updates, :dependent => :destroy
  
  #categories
  acts_as_taggable_on :categories
  
  has_many :users, :through => :backs
  
  accepts_nested_attributes_for :rewards, :reject_if => lambda { |a| a[:description].blank? }, :allow_destroy => true

  attr_accessible :rewards_attributes, :title, :description, :video_link, :money, :deadline
  
  # workflow  
  state_machine :initial => :unpublished do
     
      state :unpublished, :published, :funded, :expired
      
      event :publish do
        transition :unpublished => :published
      end
      
      event :unpublish do
        transition :published => :unpublished
      end
      
      event :fund_raised do
        transition :published => :funded
      end
      
      event :expire do
        transition [:published, :unpublished, :funded] => :expired
      end
      
  end

  #expire project after deadline
  after_initialize :check_deadline
  
  def check_deadline
    if !new_record? 
      if(self.state != "expired" && Time.now > self.deadline)
        self.expire! 
      end
    end
  end
    
  default_scope without_state(:unpublished)
  scope :published, without_state(:unpublished)
  scope :funded, with_state(:funded)
  scope :unpublished, with_state(:unpublished)
  scope :expired, with_state(:expired)
  # scope :owned, :user_id => current_user
    
    def total
      backs.find_all_by_project_id(self).sum(&:amount)
    end
    
    # create relationship table
    def transform!(proposal)
       Proptoproj.create!(:proposal_id => proposal.id, :project_id => self.id)
    end
    
    def self.feed(last)
    		self.where("created_at < ? ", last).order('created_at desc').limit(5)
    end
    
  
    
end

