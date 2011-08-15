class Lead < ActiveRecord::Base
  belongs_to :project

  validates :project_id, :presence => true
  validates :featimage, :presence => true
  
  attr_accessible :featimage, :project_id, :title
  has_attached_file :featimage, 
                    :path => ":rails_root/public/uploads/leads/:id/:basename.:extension",
                    :url => "/uploads/leads/:id/:basename.:extension"
  
  before_create :unique_file_name
  
  private
    def unique_file_name
       extension = File.extname(picture_file_name).downcase
       self.picture.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(32)}#{extension}")
     end
  
end