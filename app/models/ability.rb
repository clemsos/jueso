class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)
    
      if user.role? :Admin
        can :manage, :all 
        
      elsif user.role? :Member
        
        can [:create], Comment
        can [:create, :destroy], Relationship
        can [:create, :destroy], Favorite
        can :create, Proposal
        can :read, Proposal, :user_id => user.id
        can :create, Project
        can [:read, :edit], Project, :user_id => user.id 
        can [:create, :edit, :update], Back
        can [:create, :destroy], Micropost        
          
       elsif user.role? :Artist
         
         can [:create, :edit, :update], Proposal
         can [:create, :edit, :update, :destroy], Gallery
         can [:create, :edit, :update,  :destroy], Upload

       elsif user.role? :Institution


        
       else 
         
        # not logged in
        
       end
    
    # Define abilities for the passed in user here. For example:
    #
    #   
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
