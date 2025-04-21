require "test_helper"

class OpinionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get opinions_create_url
    assert_response :success
  end
end
