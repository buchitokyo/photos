class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: 'アカウントが作成されました'
    else
      render 'new'
    end
  end

  def show
    @user = current_user
    @favorite_pictures = @user.favorite_pictures
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation, :icon, :icon_cache)
  end
end
