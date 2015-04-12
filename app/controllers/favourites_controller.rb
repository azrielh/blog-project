class FavouritesController < ApplicationController

  def index
    @favourite_posts = current_user.favourite_posts
  end

  def create
    post = Post.find params[:post_id]
    favourite = current_user.favourites.new
    favourite.post = post

    if favourite.save
      redirect_to post, notice: "Blog Post favourited"
    else
      redirect_to post, notice: "Trouble favouriting post"
    end
  end

  def destroy
    post = Post.find params[:post_id]
    favourite = current_user.favourites.find params[:id]
    favourite.destroy

    redirect_to post_path(post), alert: "Favourite removed :("

  end

end
