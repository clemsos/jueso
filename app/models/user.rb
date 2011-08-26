class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, 
         :validatable, :email_regexp => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  

   before_create :setup_role
   before_validation :beta_invited?

   def beta_invited?
     unless BetaInvite.exists?(:email=>email)
          errors.add :email, "is not on our beta list"  
     end
         
    #  unless %w{betalist}.include? email
    #    errors.add :email, "is not on the beta list."
    #  end
   end
         
        

validates_uniqueness_of :username, :email
validates_uniqueness_of :alias, :on => :update
validates_presence_of :password, :on => :create
validates_presence_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@" 
validates :username, :presence => true, :length => { :maximum => 40 }
validates :email, :presence => true, :email_format => true
  
#categories
acts_as_taggable_on :skills

default_scope :order => 'users.created_at DESC'

 def self.with_role(role_name)
    Role.where(:name => role_name).first.users # hope title is validated uniq
  end


  # Add user roles
  has_and_belongs_to_many :roles
  has_many :change_role
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :bio, :link, :alias, :city, :weibo
  
  # Add projects
  has_many :proposals
  has_many :projects
  has_many :backs
  has_many :comments
  has_many :backed_projects, :through => :backs, :source => :project, :group => "project.id"
  has_many :favorites
  has_many :favorite_projects, :through => :favorites, :source => :project
  has_many :updates
    
  #add galleries
  has_many :galleries
  
  #add tags
  acts_as_tagger 
  
  #Add avatar
  attr_accessible :avatar, :crop_x, :crop_y, :crop_w, :crop_h  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h  
  has_attached_file :avatar,
                    :path => ":rails_root/public/uploads/:class/:id/:basename.:extension",
                    :url => "/uploads/:class/:id/:basename.:extension",
                    :styles => { :mini => '80x80#', :normal => "200x200#", :large => "400x400>" },
                    :processors => [:cropper]
                  
                    
#  validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => [ 'image/jpeg', 'image/png', 'image/pjpeg', 'image/gif','image/png' ]
  
  before_post_process :unique_file_name
  after_update :reprocess_avatar, :if => :cropping?
  
  def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  # helper method used by the cropper view to get the real image geometry
  def avatar_geometry(style = :original)
      @geometry ||= {}
      @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
  
  MAX_CROP_WIDTH = 500
  PREVIEW_WIDTH  = 200
  PREVIEW_HEIGHT = 200
                    
  #Add microposts
  has_many :microposts, :dependent => :destroy
  
  
  #Add relationship
  has_many :relationships, :foreign_key => "follower_id",
                             :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed  
  has_many :reverse_relationships, :foreign_key => "followed_id",
           :dependent => :destroy, :class_name => "Relationship"
  has_many :followers, :through => :reverse_relationships, :source => :follower  
  
    
  #follow method
  def following?(followed) 
    relationships.find_by_followed_id(followed)
  end
  
  def follow!(followed) 
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed) 
    relationships.find_by_followed_id(followed).destroy
  end
  
  def feed
      Micropost.from_users_followed_by(self)
  end
  
  #favorite method
  def favorable?(project) 
    favorites.find_by_project_id(project)
  end
  
  def favorable!(project) 
    favorites.create!(:project_id => project.id)
  end
  
  def unfavorable!(project) 
    favorites.find_by_project_id(project).destroy
  end

  
  #role method
  def role?(role)
     return !!self.roles.find_by_name(role.to_s)
  end
  
  def role
    roles.first
  end

  
  private
  
    def setup_role
      if self.role_ids.empty?
        self.role_ids = [2]
      end
    end         
   
     def reprocess_avatar
       self.avatar.reprocess!
     end
   
     def unique_file_name
       extension = File.extname(picture_file_name).downcase
       self.picture.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(32)}#{extension}")
     end


end
