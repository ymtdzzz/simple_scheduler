require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @task = tasks(:one)
  end

  test "ログインしていないユーザーはタスクを作成できない" do
    assert_no_difference 'Task.count' do
      post tasks_path, params: { task: { title: "Lorem ipsum",
                          start: Time.mktime(2019, 1, 1),
                          end: Time.mktime(2019, 1, 2)}}
    end
    assert_redirected_to login_url
  end

  test "ログインしていないユーザーはタスクを削除できない" do
    assert_no_difference 'Task.count' do
      delete task_path(@task)
    end
    assert_redirected_to login_url
  end

  test "違うユーザーのタスクは削除できない" do
    log_in_as(users(:michael))
    task = tasks(:six)
    assert_no_difference 'Task.count' do
      delete task_path(task)
    end
    assert_redirected_to root_url
  end
end
