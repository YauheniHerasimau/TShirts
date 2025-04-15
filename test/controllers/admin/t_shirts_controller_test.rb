require "test_helper"

class Admin::TShirtsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_t_shirts_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_t_shirts_create_url
    assert_response :success
  end
end
