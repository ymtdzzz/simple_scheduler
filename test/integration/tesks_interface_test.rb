require 'test_helper'

class TesksInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  # test "予定のインターフェース" do
  #   log_in_as(@user)
  #   get root_path
  #   # 無効な送信
  #   assert_no_difference 'Task.count' do
  #     post tasks_path, params: { task: { title: "" }}
  #   end
  #   assert_select 'div#error_explanation'
  #   # 有効な送信
  #   assert_difference 'Task.count', 1 do
  #     post tasks_path, params: { task: { title: "Test Task",
  #                       start: Time.mktime(2019, 1, 1), 
  #                       end: Time.mktime(2019, 1, 2)}}
  #   end
  #   assert_redirect_to root_url
  #   follow_redirect!
  #   assert_match content, response.body
  #   # 投稿の削除
  #   assert_select 'a', text: '削除'
  #   first_task = @user.tasks.paginate(page: 1).first
  #   assert_difference 'Task.count', -1 do
  #     delete tasks_path(first_task)
  #   end
  #   # 違うユーザーのページには削除リンクがない
  #   get user_path(users(:archer))
  #   assert_select 'a', text: '削除', count: 0
  # end
end
