module ApplicationHelper
  
  def display_login_info
    if current_user
      raw "#{link_to current_user.real_name, user_url(current_user)} | #{link_to 'Logout', logout_url}"
    else
      raw "#{link_to "Login", login_url} or #{link_to "Signup", new_user_url}"
    end
  end
  
end
