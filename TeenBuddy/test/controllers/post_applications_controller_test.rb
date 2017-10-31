require 'test_helper'

class PostApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_application = post_applications(:one)
  end

  test "should get index" do
    get post_applications_url
    assert_response :success
  end

  test "should get new" do
    get new_post_application_url
    assert_response :success
  end

  test "should create post_application" do
    assert_difference('PostApplication.count') do
      post post_applications_url, params: { post_application: { post_id: @post_application.post_id, teenager_id: @post_application.teenager_id } }
    end

    assert_redirected_to post_application_url(PostApplication.last)
  end

  test "should show post_application" do
    get post_application_url(@post_application)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_application_url(@post_application)
    assert_response :success
  end

  test "should update post_application" do
    patch post_application_url(@post_application), params: { post_application: { post_id: @post_application.post_id, teenager_id: @post_application.teenager_id } }
    assert_redirected_to post_application_url(@post_application)
  end

  test "should destroy post_application" do
    assert_difference('PostApplication.count', -1) do
      delete post_application_url(@post_application)
    end

    assert_redirected_to post_applications_url
  end
end
