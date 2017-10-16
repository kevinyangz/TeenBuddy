require 'test_helper'

class TeenagersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teenager = teenagers(:one)
  end

  test "should get index" do
    get teenagers_url
    assert_response :success
  end

  test "should get new" do
    get new_teenager_url
    assert_response :success
  end

  test "should create teenager" do
    assert_difference('Teenager.count') do
      post teenagers_url, params: { teenager: { birth_date: @teenager.birth_date, cell_phone: @teenager.cell_phone, home_address: @teenager.home_address, home_phone: @teenager.home_phone, name: @teenager.name } }
    end

    assert_redirected_to teenager_url(Teenager.last)
  end

  test "should show teenager" do
    get teenager_url(@teenager)
    assert_response :success
  end

  test "should get edit" do
    get edit_teenager_url(@teenager)
    assert_response :success
  end

  test "should update teenager" do
    patch teenager_url(@teenager), params: { teenager: { birth_date: @teenager.birth_date, cell_phone: @teenager.cell_phone, home_address: @teenager.home_address, home_phone: @teenager.home_phone, name: @teenager.name } }
    assert_redirected_to teenager_url(@teenager)
  end

  test "should destroy teenager" do
    assert_difference('Teenager.count', -1) do
      delete teenager_url(@teenager)
    end

    assert_redirected_to teenagers_url
  end
end
