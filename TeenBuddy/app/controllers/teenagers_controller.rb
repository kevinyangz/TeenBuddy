# This class is being invoked after user successfully register using Email and password
# Enter Detail information.
# 

class TeenagersController < ApplicationController
  before_action :set_teenager, only: [:show, :edit, :update, :destroy]

  # GET /teenagers
  # GET /teenagers.json
  def index
    @teenagers = Teenager.all

  end

  # GET /teenagers/1
  # GET /teenagers/1.json
  def show
    @current_teenager_interest= TeenagerInterest.where(teenager_id:params[:id]).all
    @age= Teenager.get_age(@teenager.birth_date)

  end

  # GET /teenagers/new
  def new
    @teenager = Teenager.new
  end

  # GET /teenagers/1/edit
  def edit
  end

  # POST /teenagers
  # 
  def create
    @teenager = Teenager.new(teenager_params)
    @teenager.user_id = current_user.id

    respond_to do |format|
    if @teenager.save
    #@age= Teenager.get_age(@teenager.birth_date)

    #@teenager.service_category_ids.each do |categories|
    #TeenagerInterest.create!(:teenager_id => @teenager.id, :service_category_id => categories)
   # end
        format.html { redirect_to @teenager, notice: 'Teenager was successfully created.' }
        format.json { render :show, status: :created, location: @teenager }
      else
        format.html { render :new }
        format.json { render json: @teenager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teenagers/1
  # PATCH/PUT /teenagers/1.json
  def update
    respond_to do |format|
      if @teenager.update(teenager_params)
        format.html { redirect_to @teenager, notice: 'Teenager was successfully updated.' }
        format.json { render :show, status: :ok, location: @teenager }
      else
        format.html { render :edit }
        format.json { render json: @teenager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teenagers/1
  # DELETE /teenagers/1.json
  def destroy
    @teenager.destroy
    respond_to do |format|
      format.html { redirect_to teenagers_url, notice: 'Teenager was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teenager
      @teenager = Teenager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teenager_params
      params.require(:teenager).permit(:fname,:lname, :home_address, 
         :cell_phone, :birth_date,:postal_code,service_category_ids: []
         )
    end
end
