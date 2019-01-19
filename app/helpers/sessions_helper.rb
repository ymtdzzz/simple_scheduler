module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # セッションの生成＆結びつける
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] =  user.remember_token
  end

  # 現在ログイン中のユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      # クッキーのuserIDでユーザーを取り出し、それがcookiesの情報と一致するか？
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ログイン中かチェック
  def logged_in?
    !current_user.nil?
  end

  # セッションの破棄
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # ログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
