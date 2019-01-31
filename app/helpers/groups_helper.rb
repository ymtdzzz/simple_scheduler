module GroupsHelper
  # ログインユーザーがそのグループの作成者か？
  def is_owner?(group)
    if group.owner == current_user
      return true
    else
      return false
    end
  end
end
