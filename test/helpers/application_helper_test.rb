require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Simple Scheduler"
    assert_equal full_title("Help"), "Help | Simple Scheduler"
  end
end 