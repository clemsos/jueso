class Upload < ActiveRecord::Base
  before_create :unique_file_name
  after_update :reprocess_picture, :if => :cropping?
  
  has_attached_file :picture, 
                    :styles => { :thumb =>  { :geometry => 'x60',
                                                         :quality => 70,
                                                         :format => 'JPG'}
                                },
                    :url => "/assets/:class/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/:class/:attachment/:id/:style/:basename.:extension",
                    :convert_options => { :all => '-strip -colorspace RGB'},
                    #:processors    => [:cropper], #[:thumbnail]
                    :default_style => :original
                  
                  
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => [ 'image/jpeg', 'image/png', 'image/pjpeg' ]

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h  
  
  MAX_CROP_WIDTH = 500
  PREVIEW_WIDTH  = 100
  PREVIEW_HEIGHT = 100
  
  # create relationship table
  def addfile!(gallery)
     GalleriesFile.create!(:gallery_id => gallery.id, :upload_id => self.id)
  end
  
  private

    def unique_file_name
      extension = File.extname(picture_file_name).downcase
      #fileNameOnly = File.basename(picture_file_name, File.extname(picture_file_name));
      self.picture.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(32)}#{extension}")
    end
  
end