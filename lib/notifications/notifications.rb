module Notifications
  
  def im_awesome
    puts "#{self} is so awesome"
  end
  
  def create_notifications(user,ref,ref_id)
    
    @ref_notifs = {
      'Favorite'=>'added to favorites',
      'Update'=>'update a project',
      'Back'=>'backed a project'
    }
    
    @micropost = Micropost.new
    @micropost.user_id = user 
    @micropost.content = @ref_notifs[ref]
    @micropost.ref = ref
    @micropost.ref_id = ref_id
    @micropost.save!
  end  
  
end

