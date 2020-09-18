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

  def leftside_header_display(passed_param)
    case passed_param
    when 'photo' then user_signed_in? ? (image_tag current_user.photo, class: 'rounded-corners-half white-bg') : ''
    when 'full_name' then user_signed_in? ? current_user.full_name : ''
    when 'followers'
      if user_signed_in?
        "
        <div>
          <p class=\"centered-text text-fith-color text-bold\">#{current_user.my_followers.size}</p>
          <p class=\"centered-text text-fith-color text-bold\">Followers</p>
        </div>
        ".html_safe
      end
    when 'following'
      if user_signed_in?
        "
        <div>
          <p class=\"centered-text text-fith-color text-bold\">#{current_user.followeds.size}</p>
          <p class=\"centered-text text-fith-color text-bold\">Following</p>
        </div>
        ".html_safe
      end
    end
  end

  def leftside_pages_navigation
    is_root = current_page?(root_path)
    is_opinion = current_page?(opinions_path)
    is_user = current_page?(user_path(current_user.id))
    "
    <div class=\"#{is_root ? 'active' : ''} text-bold text-uppercase width-100 padding-1 centered-text\">
      <i class=\"fa fa-home white-text\" aria-hidden=\"true\"></i>
      #{link_to 'Home', root_path, class: 'white-text'}
    </div>
    <div class=\"#{is_opinion ? 'active' : ''} text-bold text-uppercase width-100 padding-1 centered-text\">
      <i class=\"fa fa-rss white-text\" aria-hidden=\"true\"></i>
      #{link_to 'Opinions', opinions_path, class: 'white-text'}
    </div>
    <div class=\"#{is_user ? 'active' : ''} text-bold text-uppercase width-100 padding-1 centered-text\">
      <i class=\"fa fa-user white-text\" aria-hidden=\"true\"></i>
      #{link_to 'Profile', user_path(current_user), class: 'white-text'}
    </div>
    ".html_safe
  end
end
