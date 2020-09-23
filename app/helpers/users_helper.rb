module UsersHelper
  def display_follow_button(user)
    return if current_user.id == user.id

    if current_user.do_i_follow_her?(user)
      link_to('Unfollow', following_path(followed: user), method: :delete, class: 'button-secondary centered-h-v follow-button')
    else
      link_to('Follow', followings_path(followed: user), method: :post, class: 'button-primary centered-h-v follow-button')
    end
  end

  def display_remember_me(form)
    if devise_mapping.rememberable?
      "<div class=\"remember-me centered-horizontal width-40\">
      #{form.check_box :remember_me}
      #{form.label :remember_me}
      </div>".html_safe
    else
      ''
    end
  end

  def display_minimum_of_characters
    if @minimum_password_length
      "<em>(#{@minimum_password_length} characters minimum)</em>".html_safe
    else
      ''
    end
  end
end
