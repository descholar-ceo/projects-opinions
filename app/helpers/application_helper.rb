module ApplicationHelper
  def display_user_signup_or_login
    display = ''
    if user_signed_in?
      display = link_to('Logout', destroy_user_session_path, method: :delete, class: 'button-secondary')
    else
      display << link_to('Sign In', new_user_session_path, class: 'button-secondary')
      display << link_to('Sign Up', new_user_registration_path, class: 'button-secondary')
    end
    display.html_safe
  end
end
