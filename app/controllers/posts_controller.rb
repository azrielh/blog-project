class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      # render text: params
      @posts = Post.search_for(params[:search]).sort_created.page(params[:page]).per(5)
    else
      @posts = Post.all.sort_created.page(params[:page]).per(5)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    # or can be written in one line
    # @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
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
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
