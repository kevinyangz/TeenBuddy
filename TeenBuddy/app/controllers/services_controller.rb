class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  # GET /services
  # GET /services.json
  def index


  end

  def applications
    if current_user.teenager
      @services = Service.where(teenager_id: current_user.teenager.id, enrollType: true)
    elsif current_user.client
      @services = Service.where(client_id: current_user.client.id, enrollType: true)
    end
    @services = @services.filter(params.slice(:status, :post))
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    puts 'here are the params'
    puts service_params
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        if service_params[:enrollType]
        format.html { redirect_to services_applications_path, notice: 'Service was successfully created.' }
        else
          format.html { redirect_to services_invitations_path, notice: 'Service was successfully created.' }
          end
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      if @service.enrollType
      format.html { redirect_to services_applications_path, notice: 'Service was successfully destroyed.' }
      else
        format.html { redirect_to services_invitations_path, notice: 'Service was successfully destroyed.' }
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
     # params.fetch(:service)
      params.require(:service).permit(:teenager_id, :post_id, :applyMessage, :status, :enrollType, :inviteMessage)
    end
end
