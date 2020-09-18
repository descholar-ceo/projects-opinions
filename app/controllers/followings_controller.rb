class FollowingsController < ApplicationController
  # POST /followings
  # POST /followings.json
  def create
    @following = current_user.followings.new(followed_id: params[:followed])

    respond_to do |format|
      if @following.save
        format.html { redirect_to user_path(current_user.id) }
        format.json { render :show, status: :created, location: @following }
      else
        format.html { render :new, alert: 'Failed to follow that user, try again!.' }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followings/1
  # DELETE /followings/1.json
  def destroy
    @following = current_user.followeds.find(params[:followed])
    if current_user.unfollow_this_user(@following)
      redirect_to user_path(current_user.id)
    else
      redirect_to user_path(current_user.id), alert: 'Your unfollowing that user has failed. Please try again!'
    end
  end
end
