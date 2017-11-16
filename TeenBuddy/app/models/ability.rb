class Ability
  include CanCan::Ability

  def initialize(user)

    if user.client
      can [:read, :update], PostApplication, PostApplication do |post_application|
        post_application.post.client_id == user.client.id &&
        post_application.status == 'Pending'
      end
      can [:create, :read, :destroy], PostInvitation, PostInvitation do |post_invitation|
        post_invitation.post.client_id == user.client.id &&
            post_invitation.status == 'Pending'
      end
    elsif user.teenager
      can [:create, :read, :destroy], PostApplication, PostApplication do |post_application|
        post_application.teenager_id == user.teenager.id &&
            post_application.status == 'Pending'
      end
      can [:read, :update], PostInvitation, PostInvitation do |post_invitation|
        post_invitation.teenager_id == user.teenager.id &&
            post_invitation.status == 'Pending'
      end
    end
  end
end
