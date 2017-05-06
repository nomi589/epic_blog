class CategoriesController < ApplicationController
  before_action :require_login, except: [:show]

  def show
    @category = Category.find_by(name: params[:id])
    @posts = @category.posts
  end

  def new
    set_back_path
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      flash[:notice] = "Category created"
      redirect_to new_category_path
    else
      render :new
    end
  end
end