class Gallery < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title, :description
  
  has_many :galleries_files
  has_many :uploads, :through => :galleries_files
end
