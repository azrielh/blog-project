class FavouritesController < ApplicationController

  def index
    @favourite_posts = current_user.favourite_posts
  end

  def create
    @post = Post.find params[:post_id]
    favourite = current_user.favourites.new
    favourite.post = @post

    respond_to do |format|
      if favourite.save
        format.html { redirect_to post, notice: "Blog Post favourited" }
        format.js { render }
      else
        format.html { redirect_to post, notice: "Trouble favouriting post" }
        format.js { render }
      end
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    favourite = current_user.favourites.find params[:id]
    favourite.destroy
    respond_to do |format|
      format.html { redirect_to post_path(post), alert: "Favourite removed :(" }
      format.js { render }
    end
  end

end
