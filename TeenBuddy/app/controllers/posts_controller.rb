class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if current_user.client
      @posts = Post.where(client_id: current_user.client.id)
      @state = 'client_posts'
    else
      @posts = Post.all
      @state = 'all'
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post_form_header_title = "Create a New Job Post"
    @post_form_header_description = "Create a new post for yourself and put it online."
    @post_form_submit_title = "Submit Your Job Post"

    if current_user.client
      @client = current_user.client
    else
      #error message if not a client
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @post_form_header_title = "Update Your Job Post"
    @post_form_header_description = "Update your job post information."
    @post_form_submit_title = "Update Your Job Post"
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.client_id = current_user.client.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path {client_id} }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
    puts @post.service_category_id
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :work_address, :pay, :number_of_teenager_needed, :service_category_id, :service_type_id)
    end
end
