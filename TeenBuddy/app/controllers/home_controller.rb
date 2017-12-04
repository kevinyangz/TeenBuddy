class HomeController < ApplicationController
before_action :check_user_info
  def index
    @total_teenagers = Teenager.count()
    @total_clients = Client.count()
    @total_posts = Post.count()
  end

def check_user_info
	if current_user
		if current_user.teenager
			if !current_user.teenager.home_address 
			    redirect_to edit_teenager_path(current_user.teenager), notice:'Please fill up your detailed information'
			end
		elsif current_user.client
			if !current_user.client.home_address
			    redirect_to edit_client_path(current_user.client), notice:'Please fill up your detailed information'

	        end
	   end
   end
end
end
