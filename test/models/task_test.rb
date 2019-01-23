require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    time = Time.mktime(2019, 1, 6)
    @task = @user.tasks.build(start: time.yesterday, end: time.tomorrow, title: "test")
  end

  test "有効性の確認" do
    assert @task.valid?
  end

  test "userIDの存在チェック" do
    @task.user_id = nil
    assert_not @task.valid?
  end

  test "startの存在チェック" do
    @task.start = nil
    assert_not @task.valid?
  end

  test "endの存在チェック" do
    @task.end = nil
    assert_not @task.valid?
  end

  test "titleの存在チェック" do
    @task.title = " "
    assert_not @task.valid?
  end

  test "titleの長さ30文字以内" do
    @task.title = "a" * 31
    assert_not @task.valid?
  end

  test "memoの長さ140文字以内" do
    @task.memo = "a" * 141
    assert_not @task.valid?
  end
end
