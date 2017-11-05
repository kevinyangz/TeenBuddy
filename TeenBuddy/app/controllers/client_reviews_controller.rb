class ClientReviewsController < ApplicationController

  before_action :set_client_review, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    #if params[:client_id].presence
     # @client_reviews = ClientReview.where(client_id: params[:client_id])
    #  @state = 'client_posts'
   # else
    #  @posts = Post.all
    #  @state = 'all'
   # end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @client_review = ClientReview.find(params[:id])
  end


end
