require "test_helper"

class Onboardings::PersonalInformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get onboardings_personal_informations_show_url
    assert_response :success
  end

  test "should get update" do
    get onboardings_personal_informations_update_url
    assert_response :success
  end
end
