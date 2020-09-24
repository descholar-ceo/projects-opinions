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

  def display_followers_list(user)
    followers = ''
    user.my_followers.each do |follower|
      followers << "<div class=\"individual-opinion-container margin-y-2\">
        #{image_tag follower.photo, class: 'width-100 circled-element'}
        <div class=\"opinion-content margin-x-1\">
          <h3>#{link_to follower.full_name, user_path(follower), class: 'text-fith-color'}</h3>
          <p  class=\"text-fith-color text-small\" >
            @#{link_to follower.username, user_path(follower), class: 'text-fith-color '}
          </p>
        </div>
      </div>"
    end
    followers.html_safe
  end

  def display_opinions_list(passed_arg)
    puts "This is the array of passed opinions #{passed_arg}"
    m_opinions = if passed_arg.is_a? User
                   passed_arg.opinions
                 else
                   passed_arg
                 end

    res = ''
    m_opinions.includes(:user).each do |opinion|
      res << "
      <div class=\"individual-opinion-container width-100\">
        #{image_tag opinion.user.photo, class: 'width-100 rounded-corners-half'}
        <div class=\"opinion-content margin-x-1\">
          <h3>#{link_to opinion.user.full_name, user_path(opinion.user), class: 'text-black-color'}</h3>
          <p class=\"text-fith-color margin-y-1\">#{opinion.text}</p>
        </div>
      </div>
      <div class=\"margin-b-3\">
        #{display_comments_list(opinion)}
        <div class=\"comment-form-container\">
          <div></div>
          #{display_form(opinion)}
        </div>
      </div>"
    end
    res.html_safe
  end

  private

  def display_comments_list(opinion)
    res = ''
    res << "<p class=\"text-small text-rightside text-third-color\">#{opinion.comments.count} comment(s)</p>"
    opinion.comments.includes(:user).each do |comment|
      res << "
      <div class=\"individual-comment\">
        <div></div>
        <p class=\"bordered-t-third\">
          #{link_to comment.user.full_name, user_path(comment.user.id), class: 'text-bold text-black-color'}:
          #{comment.body}
        </p>
      </div>"
    end
    res.html_safe
  end

  def display_form(opinion)
    fields = form_for(opinion.comments.new, url: comments_path(opinion_id: opinion), class: 'comment-form') do |f|
      f.text_field :body, class: 'width-100 rounded-corners-half', placeholder: 'Comment on this opinion...'
    end
    fields
  end
end
