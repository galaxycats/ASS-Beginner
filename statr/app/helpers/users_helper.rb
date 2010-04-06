module UsersHelper
  
  def follow_user_button
    if logged_in?
      if current_user == @user
        ""
      elsif current_user.follows?(@user)
        content_tag(:span, button_to("Unfollow", unfollow_user_url(@user), :class => "unfollow_button"))
      elsif !current_user.follows?(@user)
        content_tag(:span, button_to("Follow", follow_user_url(@user), :class => "follow_button"))
      end
    end
  end
  
end
