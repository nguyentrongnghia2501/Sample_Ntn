require "test_helper"

class EmotesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get emotes_show_url
    assert_response :success
  end
end
