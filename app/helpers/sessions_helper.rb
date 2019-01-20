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

  # ログインしているユーザーのものか調べる
  def correct_user?(user)
    user == current_user
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

  # 記憶したURLにリダイレクトする
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを記憶する
  def store_location
    # GETの場合のみ保存
    session[:forwarding_url] = request.original_url if request.get?
  end
end
