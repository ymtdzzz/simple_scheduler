module TasksHelper
  # ログインユーザーがその予定の作成者か？
  def is_owner?(task)
    if task.owner == current_user
      return true
    else
      return false
    end
  end

  # 既に参加済みのユーザーか？
  def is_member?(task)
    task.users.include?(current_user)
  end
end
