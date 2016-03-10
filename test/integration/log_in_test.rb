require 'test_helper'

class LogInTest < ActionDispatch::IntegrationTest
  test "log in works" do
    get root_path
  end
end
