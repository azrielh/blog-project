class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    #check that this is the connection between the @post_id
    @comment.post = @post
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        CommentsMailer.notify_post_owner(@comment).deliver_later
        format.html { redirect_to post_path(@post), notice: "Comment Created!" }
        format.js { render }
      else
        #clarify this render: as we are in the comments controller...
        format.html { render 'posts/show' }
        format.js { render }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Comment Deleted" }
      format.js { render }
    end
  end

  def edit
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
  end

  def update
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    respond_to do |format|
      if @comment.update params.require(:comment).permit(:body)
        format.html { redirect_to @post, notice: "Comment updated" }
        format.js { render :update_success }
      else
        format.html { render :edit }
        format.js { render :update_failure }
      end
    end

  end


end
