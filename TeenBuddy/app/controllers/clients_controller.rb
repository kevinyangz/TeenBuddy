class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show, :edit, :update, :destroy]


  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all.filter(params.slice(:searched_keyword, :address)).reverse.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
    @client_form_header_title = "Create a New Client"
    @client_form_header_description = "Please tel us a little more about yourself."
    @client_form_submit_title = "Register"
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    @client_form_header_title = "Edit Your Information"
    @client_form_header_description = "Edit your phone number, address, description, etc."
    @client_form_submit_title = "Update Your Profile"
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
    @client.user_id = current_user.id

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:fname, :lname, :home_address, :selfie ,:description, :home_phone, :cell_phone)
    end
end
