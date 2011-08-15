module UsersHelper

  def gravatar_for(user, options = { :size => 50 })
      gravatar_image_tag(user.email.downcase, :alt => user.email,
                                              :class => 'gravatar',
                                              :gravatar => options)
  end
  
  def current_user?(user)
     user == current_user
   end
   
   def crop_avatar_img_tag(avatar, width, height, id)
     
     if width > User::MAX_CROP_WIDTH
       image_tag avatar.url(:original), :id => id, :width => User::MAX_CROP_WIDTH, :height => (height*User::MAX_CROP_WIDTH/width).to_i
       
     else
       image_tag avatar.url(:original), :id => id
     end
   end
end