class FollowersController < ApplicationController

  def new
    user_followed = User.find(params[:id])
    Follower.create(followed: user_followed, follower: current_user )
    

    redirect_to '/users'
    #respond to do |format|

    #end

  end

  def destroy

  end
end
