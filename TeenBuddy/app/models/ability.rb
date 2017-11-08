class Ability
  include CanCan::Ability

  def initialize(user)
    puts '1'

    if user.client
      puts '2'
      can [:read, :update], PostApplication, PostApplication do |post_application|

        post_application.post.client_id == user.client.id &&
        post_application.status == 'Pending'
      end
    elsif user.teenager
      puts '3'
      can :read, :all
    end
  end
end
