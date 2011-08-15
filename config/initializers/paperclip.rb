#ADD THIS
# @apneadiving
# this file provides refactoring for all models using paperclip
# set your own values in the model to override these

Paperclip.interpolates :normalized_name do |attachment, style|
    attachment.instance.normalized_name
end

module Paperclip
    
  module InstanceMethods
    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
    
    def attachment_name
      self.class.attachment_definitions.first.at(0).to_s
    end
    
    def normalized_name
      eval( attachment_name + '_file_name').gsub( /[^a-zA-Z0-9_\.]/, '_') 
    end
    
    def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
    end

    def picture_geometry(style = :original)
      @geometry ||= {}
      @geometry[style] ||= Paperclip::Geometry.from_file(eval(attachment_name).path(style))
    end

    private

    def reprocess_picture
      eval(attachment_name).reprocess!
    end
    
  end
  
end