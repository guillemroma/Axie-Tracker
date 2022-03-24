class FollowersController < ApplicationController

  def new

    user_followed = User.find(params[:id])
    Follower.create(followed: user_followed, follower: current_user )
    user = user_followed

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "/users/user_card", locals: { user: user }, formats: [:html] }
    end

  end

  def destroy

    user_followed = User.find(params[:id])
    favorite = Follower.where(followed_id: user_followed.id, follower_id: current_user.id).first
    favorite.destroy
    user = user_followed

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "/users/user_card", locals: { user: user }, formats: [:html] }
    end

  end
end
