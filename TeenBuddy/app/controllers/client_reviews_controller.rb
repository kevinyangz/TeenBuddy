class ClientReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client_review, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if params[:client_id].presence
     @client_review = ClientReview.where(client_id: params[:client_id])
    #  @state = 'client_posts'
   # else
    #  @posts = Post.all
    #  @state = 'all'
    end
  end

  # GET /client_reviews/1
  # GET /client_reviews/1.json
  def show
    @client_review = ClientReview.find(params[:id])
  end

  # GET /client_reviews/new
  def new
    @client_review = ClientReview.new
    #@post_form_header_title = "Create a New Job Post"
   # @post_form_header_description = "Create a new post for yourself and put it online."
   # @post_form_submit_title = "Submit Your Job Post"

    #if current_user.client
    #  @client = current_user.client
   # else
   #   #error message if not a client
   # end
  end



  # POST /client_reviews
  # POST /client_reviews.json
  def create
    @client_review = ClientReview.new(client_review_params)
    @client_review.client_id = current_user.client.id

    respond_to do |format|
      if @client_review.save
        format.html { redirect_to client_reviews_path {client_id} }
        format.json { render :show, status: :created, location: @client_review }
      else
        format.html { render :new }
        format.json { render json: @client_review.errors, status: :unprocessable_entity }
      end
    end
    puts @client_review.service_category_id
  end



  public
  def apply_filter
    #redirect_to new_post_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_client_review
    @client_review = ClientReview.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_review_params
    params.require(:client_review).permit( :score, :review)
  end

end
