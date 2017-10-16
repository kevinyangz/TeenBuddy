class HomeController < ApplicationController
  def index
    @total_teenagers = Teenager.count();
  end
end
