module ApplicationHelper
  def display_user_signup_or_login
    display = ''
    if user_signed_in?
      display = link_to('Logout', destroy_user_session_path, method: :delete, class: 'button-danger')
    else
      display << link_to('Sign In', new_user_session_path, class: 'button-info')
      display << link_to('Sign Up', new_user_registration_path, class: 'button-info')
    end
    display.html_safe
  end

  def display_create_button
    button_display = ''
    if user_signed_in?
      button_display << link_to('My opinions', opinions_path, class: 'button-info')
      button_display << link_to('New opinion', new_opinion_path, class: 'button-info')
    end
    button_display.html_safe
  end
end
