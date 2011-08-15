class RewardsController < ApplicationController

  # GET /projects/1/edit
  def edit
    @reward = Reward.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @reward = Reward.new(params[:project])
    @reward.project_id = current_user.id
    
    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Reward was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end




end
