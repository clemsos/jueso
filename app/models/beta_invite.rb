class BetaInvite < ActiveRecord::Base
  validates :email, :presence => true, :email_format => true
end
