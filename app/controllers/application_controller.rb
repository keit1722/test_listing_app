class ApplicationController < ActionController::Base
  add_flash_types :error, :success, :warning

  def not_authenticated
    redirect_to login_path, error: 'ログインしてください'
  end

  def require_logout
    redirect_to root_path, error: 'ログアウトしてください' if logged_in?
  end

  def only_business
    redirect_to root_path unless current_user.business?
  end
end
