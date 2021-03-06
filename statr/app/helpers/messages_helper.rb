module MessagesHelper

  def custom_error_messages_for(message, options = {})
    if message && !message.errors.count.zero?
      html = {}
      [:id, :class].each do |key|
        value = options[key] if options.include?(key)
        html[key] = value.blank? ? 'errorExplanation' : value
      end

      header_message = "We couldn't save this Status because:"

      error_messages = message.errors.map do |attribute_with_error, error|
        content_tag(:li, ERB::Util.html_escape("It #{error}"))
      end.join

      contents = ''
      contents << content_tag(:h2, header_message)
      contents << content_tag(:ul, error_messages)

      content_tag(:div, contents, html)
    end
  end
  
  def display_mention_info_for(message)
    raw '<span class="mentioned_by">mentioned</span>' if message.is_a? Mention
  end
  
  def auto_markup(message)
    link_tags(link_usernames(auto_link(sanitize(message))))
  end
  
  def link_usernames(content)
    content.gsub(/@([\w\d]+)/) do |matched_string|
      content_tag(:span, link_to(matched_string, user_url(:id => $1)), :class => "mentioned_user")
    end
  end
  
  def link_tags(content)
    content.gsub(/#([\w\d]+)/) do |matched_string|
      content_tag(:span, link_to(matched_string, "#"), :class => "tag")
    end
  end

  def display_user_image_for(user, size=:default)
    size_modifier = case size
    when :big
      "_big"
    else
      ""
    end
    
    image_url = File.exists?(File.join(Rails.root, "public/images/user_images/#{user.username}#{size_modifier}.png")) ? "/images/user_images/#{user.username}#{size_modifier}.png" : "/images/default_user_image#{size_modifier}.png"
    
    link_to image_tag(image_url, :alt => "Profile page of #{user.username}", :class => "gravatar_image"), user_url(user)
  end
  
end