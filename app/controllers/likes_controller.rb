class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    post = Post.find params[:post_id]
    like = current_user.likes.new
    like.post = post
    if like.save
      redirect_to post, notice: "Liked!"
    else
      redirect_to post, alert: "Like not working, try again!"
    end
  end

  def destroy
    like = current_user.likes.find params[:id]
    like.destroy
    redirect_to like.post, notice: "Unliked :("
  end

end
