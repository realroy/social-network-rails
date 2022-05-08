require "test_helper"

class Onboardings::InterestsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get onboardings_interests_show_url
    assert_response :success
  end

  test "should get update" do
    get onboardings_interests_update_url
    assert_response :success
  end

  test "should get destroy" do
    get onboardings_interests_destroy_url
    assert_response :success
  end
end
