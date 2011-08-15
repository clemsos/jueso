class Proptoproj < ActiveRecord::Base
  belongs_to :project
  belongs_to :proposal
  
  validates :project_id, :presence => true
  validates :proposal_id, :presence => true
  
end
