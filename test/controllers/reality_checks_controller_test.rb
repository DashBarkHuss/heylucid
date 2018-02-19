require 'test_helper'

class RealityChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reality_check = reality_checks(:one)
  end

  test "should get index" do
    get reality_checks_url
    assert_response :success
  end

  test "should get new" do
    get new_reality_check_url
    assert_response :success
  end

  test "should create reality_check" do
    assert_difference('RealityCheck.count') do
      post reality_checks_url, params: { reality_check: {  } }
    end

    assert_redirected_to reality_check_url(RealityCheck.last)
  end

  test "should show reality_check" do
    get reality_check_url(@reality_check)
    assert_response :success
  end

  test "should get edit" do
    get edit_reality_check_url(@reality_check)
    assert_response :success
  end

  test "should update reality_check" do
    patch reality_check_url(@reality_check), params: { reality_check: {  } }
    assert_redirected_to reality_check_url(@reality_check)
  end

  test "should destroy reality_check" do
    assert_difference('RealityCheck.count', -1) do
      delete reality_check_url(@reality_check)
    end

    assert_redirected_to reality_checks_url
  end
end
