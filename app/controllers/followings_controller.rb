class FollowingsController < ApplicationController
  def create
    @following = current_user.followings.new(followed_id: params[:followed])

    if @following.save
      redirect_to root_path
    else
      render root_path, alert: 'Failed to follow that user, try again!'
    end
  end

  def destroy
    @following = current_user.followeds.find(params[:followed])
    if current_user.unfollow_this_user(@following)
      redirect_to root_path
    else
      redirect_to root_path, alert: 'Your unfollowing that user has failed. Please try again!'
    end
  end
end
