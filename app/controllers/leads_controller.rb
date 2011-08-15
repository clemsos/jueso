class LeadsController < ApplicationController
  
  def index
    @leads = Lead.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leads }
    end
  end
    

end
