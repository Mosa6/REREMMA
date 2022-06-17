class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_my_page_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def ensure_guest_user
    @user = current_user
    if @user.name == "guestuser"
      redirect_to users_my_page_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
