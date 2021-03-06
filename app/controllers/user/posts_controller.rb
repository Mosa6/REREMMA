class User::PostsController < ApplicationController

  before_action :correct_user, only: [:edit, :destroy, :update]

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @user = @post.user
    gon.post = @post
  end

  def index
    @posts = Post.page(params[:page])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render "new"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def search #簡易検索機能
    @posts = if params[:search].present?
      Post.where(['name LIKE ? OR address LIKE ?',
                  "%#{params[:search]}%", "%#{params[:search]}%"])#検索ワードの前後に%を置くことで空白文字を含む任意の複数文字列」が検索ワードの前後に含まれてもその文字列を持つレコードを返す
             else
                Post.none
             end
  end

  private

  def post_params
    params.require(:post).permit(:name, :latitude, :longitude, :introduction, :address, :image, :rate)
  end

  def correct_user
    @post = Post.find(params[:id])
    @user = @post.user
    redirect_to(posts_path) unless @user == current_user
  end

end
