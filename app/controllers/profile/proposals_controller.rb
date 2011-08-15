class Profile::ProposalsController < ProfileController
  before_filter :authenticate_user!
  
  def index
     @proposals = current_user.proposals.all
     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @proposals }
     end
   end
   
  
  def new
    @proposal = Proposal.new
    
    respond_to do |format|
      format.html { redirect_to(profile_proposal(@proposal)) }
      format.xml  { render :xml => @proposal }
    end
  end
  
  def create
    @proposal = Proposal.new(params[:proposal])
    @proposal.user_id = current_user.id
        
    respond_to do |format|
      if @proposal.save
        flash[:success] = "Thanks for your proposition !"
        format.html { redirect_to(profile_proposal(@proposal)) }
        format.xml  { render :xml => @proposal, :status => :created, :location => @proposal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proposal }
    end
  end 
  
  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy

    respond_to do |format|
      format.html { redirect_to(profile_proposals_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def update
    @proposal = Proposal.find(params[:id])
    
    respond_to do |format|
      if @proposal.update_attributes(params[:proposal])
        format.html { redirect_to(@proposal, :notice => 'Proposal status was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  def rejecteds
    @proposals = Proposal.find(state(:rejected))
  end
end
