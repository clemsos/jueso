class ProposalsMailer < ActionMailer::Base
  default :from => "clement@jue.so"
  
  def accept_email(proposal)
      @proposal = proposal
      @user = proposal.user
      @url  = proposal_url(@proposal)
      mail(:to => @user.email,
           :subject => "Congratulations ! Your project has been accepted")
  end
  
  def improve_email(proposal)
      @proposal = proposal
      @user = proposal.user
      @url  = proposal_url(@proposal)
      mail(:to => @user.email,
           :subject => "We would like to know more about your project")
  end
  
  def reject_email(proposal)
      @proposal = proposal
      @user = proposal.user
      @url  = proposal_url(@proposal)
      mail(:to => @user.email,
           :subject => "Your project has been rejected")
  end
  
end
