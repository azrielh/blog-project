class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    @post = Post.find params[:post_id]
    like = current_user.likes.new
    like.post = @post
    respond_to do |format|
      if like.save
        format.html { redirect_to post, notice: "Liked!" }
        format.js { render }
      else
        format.html { redirect_to post, alert: "Like not working, try again!" }
        format.js { render }
      end
    end
  end

  def destroy
    like = current_user.likes.find params[:id]
    @post = like.post
    # @post = Post.find params[:post_id]
    like.destroy
    respond_to do |format|
      format.html { redirect_to like.post, notice: "Unliked :(" }
      format.js { render }
    end
  end

end
