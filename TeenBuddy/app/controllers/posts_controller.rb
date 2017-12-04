class PostsController < ApplicationController
  require 'will_paginate/array'
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if params[:client_id].presence
      @posts = Post.all.filter(params.slice(:searched_keyword, :address, :status)).where(client_id: params[:client_id]).order(params[:order]).reverse.paginate(:page => params[:page], :per_page => params[:per_page])
      @state = 'client_posts'
    elsif params[:teenager_id].presence
      @posts = Service.where(teenager_id: params[:teenager_id]).reverse.paginate(:page => params[:page], :per_page => params[:per_page])
      @state = 'teenager_posts'
    else
      #get the array and then use where to transform back to activerecord_relation
      @posts = Post.all.filter(params.slice(:searched_keyword, :address, :status ,:category_id, :type_id)).order(params[:order]).reverse.paginate(:page => params[:page], :per_page => params[:per_page])
      @state = 'all'
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    if current_user.teenager
      @post_client=Client.find(@post.client_id).user_id
    end
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
        format.html { redirect_to @post }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
      format.html { redirect_to posts_path(client_id:current_user.client.id, per_page:5), notice: 'Post was successfully destroyed.' }
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
      params.require(:post).permit(:title,:tag_list, :description, :work_address, :pay, :number_of_teenager_needed, :service_category_id, :service_type_id, :requirements)
    end
end
