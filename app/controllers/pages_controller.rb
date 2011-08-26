class PagesController < ApplicationController
  
    def home
      @title = "Home"
      @users = User.all(:limit => 7)
      @projects = Project.all(:limit => 4)
      @leads = Lead.all(:limit => 5)
      @comments = Comment.all(:limit => 5)
    end

    def contact
      @title = "Contact"
    end

    def about
      @title = "About"
    end
  
    def faq
      @title = "FAQ"
    end
    
    def temp
      render :layout => 'temp'
    end
      
end
