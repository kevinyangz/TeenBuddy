class HomeController < ApplicationController
  before_action :check_user_profile
  def index
    @total_teenagers = Teenager.count()
    @total_clients = Client.count()
    @total_posts = Post.count()
  end

  def check_user_profile
    if current_user
      case current_user.role
        when 'teenager'
          redirect_to new_teenager_path if current_user.teenager == nil
        when 'client'
          redirect_to new_client_path if current_user.client?  == nil
        else
          redirect_to new_teenager_path
      end
    end
  end

end
