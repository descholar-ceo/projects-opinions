module UsersHelper
  def display_follow_button(user)
    return if current_user.id == user.id

    if current_user.do_i_follow_her?(user)
      link_to('Unfollow', following_path(followed: user),
              method: :delete,
              class: 'button-secondary centered-h-v follow-button')
    else
      link_to('Follow', followings_path(followed: user),
              method: :post,
              class: 'button-primary centered-h-v follow-button')
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

  def display_comments_list(opinion)
    opinion.comments.includes(:user).each do |comment|
      return "
      <p class=\"text-small text-rightside text-third-color\">#{opinion.comments.count} comments</p>
      <div class=\"individual-comment\">
        <div></div>
        <p class=\"bordered-t-third\">
          #{link_to comment.user.full_name, user_path(comment.user.id), class: 'text-bold text-black-color'}:
          #{comment.body}
        </p>
      </div>".html_safe
    end
  end

  def display_followers_list(user)
    user.my_followers.each do |follower|
      return "<div class=\"individual-opinion-container margin-y-2\">
        #{image_tag follower.photo, class:'width-100 circled-element'}
        <div class=\"opinion-content margin-x-1\">
          <h3>#{link_to follower.full_name, user_path(follower), class: "text-fith-color"}</h3>
          <p  class=\"text-fith-color text-small\" >
            @#{link_to follower.username, user_path(follower), class: 'text-fith-color '}
          </p>
        </div>
      </div>".html_safe
    end
  end
end
