class CommentsMailer < ApplicationMailer

  def notify_post_owner(comment)
  	@comment = comment
  	@post = comment.post
  	@user = @post.user
  	mail(to: @user.email, subject: "You got an comment on your blog!")
  end


end
