class Admin::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.page(params[:page])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  def post_params
      params.require(:post).permit(:name, :latitude, :longitude, :introduction, :address, :image)
  end

end
