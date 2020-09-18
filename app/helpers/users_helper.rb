module UsersHelper
  def display_follow_button(user)
    return if current_user.id == user.id

    if current_user.do_i_follow_her?(user)
      link_to('Unfollow', following_path(followed: user), method: :delete, class: 'button-secondary')
    else
      link_to('Follow', followings_path(followed: user), method: :post, class: 'button-primary')
    end
  end
end
