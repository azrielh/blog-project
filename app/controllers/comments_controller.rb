class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    #check that this is the connection between the @post_id
    @comment.post = @post

    if @comment.save
      redirect_to post_path(@post)
    else
      #clarify this render: as we are in the comments controller...
      render 'posts/show'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment Deleted"
  end

end
