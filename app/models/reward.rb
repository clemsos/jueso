class Reward < ActiveRecord::Base
  belongs_to :project
#  validates_numericality_of :project_id
  validates_numericality_of :amount_max
  validates_numericality_of :amount_min
end