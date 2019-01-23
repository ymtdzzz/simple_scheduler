class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # ログインしてなければエラー表示
    def logged_in_user
      unless logged_in?
        store_location  # GETでアクセスしようとしたURLを記憶
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
end
