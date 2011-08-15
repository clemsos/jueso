class GalleriesFile < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :upload
  
  validates :gallery_id, :presence => true
  validates :upload_id, :presence => true
  
end