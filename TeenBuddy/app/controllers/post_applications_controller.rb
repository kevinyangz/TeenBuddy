class PostApplicationsController < ApplicationController
  before_action :set_post_application, only: [:show, :edit, :update, :destroy]

  # GET /post_applications
  # GET /post_applications.json
  def index
    if current_user.client
      @post_applications = PostApplication.joins(:post).where(['posts.client_id= ?',current_user.client.id])
      @state ='client_applications'
    elsif current_user.teenager
      @post_applications=PostApplication.where(teenager_id: current_user.teenager.id)
      @state ='teenager_applications'
    end
  end

  # GET /post_applications/1
  # GET /post_applications/1.json
  def show
  end

  # GET /post_applications/new
  def new
    @post_application = PostApplication.new
  end

  # GET /post_applications/1/edit
  def edit
  end

  # POST /post_applications
  # POST /post_applications.json
  def create
    @post_application = PostApplication.new(post_application_params)

    respond_to do |format|
      if @post_application.save

        format.html { redirect_to post_applications_path, notice: 'Post application was successfully created.' }
        format.json { render :show, status: :created, location: @post_application }
      else
        format.html { render :new }
        format.json { render json: @post_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_applications/1
  # PATCH/PUT /post_applications/1.json
  def update
    respond_to do |format|
      if @post_application.update(status: params[:status])
        format.html { redirect_to post_applications_path, notice: 'Post application was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_application }
      else
        format.html { render :edit }
        format.json { render json: @post_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_applications/1
  # DELETE /post_applications/1.json
  def destroy
    @post_application.destroy
    respond_to do |format|
      format.html { redirect_to post_applications_url, notice: 'Post application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_application
      @post_application = PostApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_application_params
      params.require(:post_application).permit(:message, :post_id, :teenager_id,:status)
    end
end
