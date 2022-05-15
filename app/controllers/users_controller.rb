class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: 'アカウント登録に成功しました'
    else
      flash.now[:error] = 'アカウント登録に失敗しました'
      render :new
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :username,
      )
  end
end
