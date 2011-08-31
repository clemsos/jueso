class Lead < ActiveRecord::Base
  belongs_to :project

  validates :project_id, :presence => true
  validates :featimage, :presence => true
  
  attr_accessible :featimage, :project_id, :title
  has_attached_file :featimage, 
                    :path => ":rails_root/public/uploads/leads/:id/:basename.:extension",
                    :url => "/uploads/leads/:id/:basename.:extension"
  
  
  validates_attachment_size :featimage, :less_than => 1.megabytes
  validates_attachment_content_type :featimage, :content_type => [ 'image/jpeg', 'image/png', 'image/pjpeg', 'image/gif','image/png' ]

  before_post_process :unique_file_name
    
  private
    def unique_file_name
       extension = File.extname(featimage_file_name).downcase
       self.featimage.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(32)}#{extension}")
     end
  
end