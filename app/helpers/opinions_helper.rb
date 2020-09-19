module OpinionsHelper
  def display_followed_by(user)
    if user.my_followers.size.positive?
      "Followed by #{link_to user.my_followers[0].username,user.my_followers[0], class: 'text-fith-color text-small'}".html_safe
    elsif user.followeds.size.positive?
      "Following #{link_to user.followeds[0].username,user.followeds[0], class: 'text-fith-color text-small'}".html_safe
    else
      'No followers, nor following'.html_safe
    end
  end
end
