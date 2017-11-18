class HomeController < ApplicationController

  def index
    @total_teenagers = Teenager.count()
    @total_clients = Client.count()
    @total_posts = Post.count()
  end



end
