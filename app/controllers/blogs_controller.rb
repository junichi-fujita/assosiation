class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to :blogs, notice: "登録しました。"
      else
        render :new
      end
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit

  end

  def update
    @blog.assign_attributes(blog_params)
    if @blog.save
      redirect_to :blogs, notice: "変更しました。"
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to :blogs, notice: "削除しました。"
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find_by(id: params[:id])
  end
end
