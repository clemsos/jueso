class ProptoprojsController < ApplicationController
  before_filter :authenticate_user!

  def create
    # @project = Project.find(params[:id])
    @proposal = Proposal.find(params[:proposal_id])
    
    @proposal.transform!(@project)
    
    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
      else
        format.html { redirect_to(@project, :flash => 'error.') }
      end
    end
  end
end