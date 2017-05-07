class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :confirm_delete, :destroy]
  before_action :post_params, only: [:create, :update]
  before_action :require_login, except: [:index, :show]
  before_action :require_author, only: [:edit, :confirm_delete, :destroy]
  before_action :set_back_path, only: [:new, :edit, :confirm_delete]

  def index
    @posts = Post.all.sort_by(&:created_at).reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      flash[:notice] = "Post created"
      redirect_to @post
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated"
      redirect_to @post
    else
      render :edit
    end
  end

  def confirm_delete

  end

  def destroy
    @post.destroy
    flash[:notice] = "Post deleted"
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, category_ids: [])
  end

  def require_author
    if @post.author != current_user
      flash[:error] = "Access denied"
      redirect_to root_path
    end
  end
end