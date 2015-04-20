class PostsController < ApplicationController

  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      # render text: params
      @posts = Post.search_for(params[:search]).sort_created.page(params[:page]).per(6)
    elsif params[:tag]
      @posts = Post.tagged_with(params[:tag]).sort_created.page(params[:page]).per(6)
    else
      @posts = Post.all.sort_created.page(params[:page]).per(6)
    end
    @post_viewed = Post.most_viewed_post
    @posts_recent = Post.recent_five
  end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(post_params)
    # @post.user = current_user
    # or can be written in one line
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
    @post.increment_view_count
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      flash[:notice] = "Could not Update!"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end


private

  def find_post
    @post = Post.find params[:id]
    redirect_to root_path, alert: "Access Denied" unless can? :manage, @post
  end

  def post_params
    params.require(:post).permit(:title, :body, :image, :tag_list)
  end
end
