class CommentsController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:body))
    @comment.author = current_user

    if @comment.save
      flash[:notice] = "Comment posted"
      redirect_to @post
    else
      render "posts/show"
    end
  end
end