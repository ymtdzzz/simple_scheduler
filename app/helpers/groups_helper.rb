module GroupsHelper
  # ログインユーザーがそのグループの作成者か？
  def is_owner?(group)
    if group.owner == current_user
      return true
    else
      return false
    end
  end

  # 既に参加済みのユーザーか？
  def is_member?(group)
    group.users.include?(current_user)
  end
end
