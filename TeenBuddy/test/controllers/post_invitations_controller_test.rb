require 'test_helper'

class PostInvitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_invitation = post_invitations(:one)
  end

  test "should get index" do
    get post_invitations_url
    assert_response :success
  end

  test "should get new" do
    get new_post_invitation_url
    assert_response :success
  end

  test "should create post_invitation" do
    assert_difference('PostInvitation.count') do
      post post_invitations_url, params: { post_invitation: { post_id: @post_invitation.post_id, teenager_id: @post_invitation.teenager_id } }
    end

    assert_redirected_to post_invitation_url(PostInvitation.last)
  end

  test "should show post_invitation" do
    get post_invitation_url(@post_invitation)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_invitation_url(@post_invitation)
    assert_response :success
  end

  test "should update post_invitation" do
    patch post_invitation_url(@post_invitation), params: { post_invitation: { post_id: @post_invitation.post_id, teenager_id: @post_invitation.teenager_id } }
    assert_redirected_to post_invitation_url(@post_invitation)
  end

  test "should destroy post_invitation" do
    assert_difference('PostInvitation.count', -1) do
      delete post_invitation_url(@post_invitation)
    end

    assert_redirected_to post_invitations_url
  end
end
