require "test_helper"

class FollowingInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  test "feed on Home page" do
    get root_path
    @user.feed.paginate(page: 1).each do |micropost|
      response.body.include?(micropost.content)
    end
  end
end
