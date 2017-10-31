class PostInvitationsController < ApplicationController
  before_action :set_post_invitation, only: [:show, :edit, :update, :destroy]

  # GET /post_invitations
  # GET /post_invitations.json
  def index
    @post_invitations = PostInvitation.all
  end

  # GET /post_invitations/1
  # GET /post_invitations/1.json
  def show
  end

  # GET /post_invitations/new
  def new
    @post_invitation = PostInvitation.new
  end

  # GET /post_invitations/1/edit
  def edit
  end

  # POST /post_invitations
  # POST /post_invitations.json
  def create
    @post_invitation = PostInvitation.new(post_invitation_params)

    respond_to do |format|
      if @post_invitation.save
        format.html { redirect_to @post_invitation, notice: 'Post invitation was successfully created.' }
        format.json { render :show, status: :created, location: @post_invitation }
      else
        format.html { render :new }
        format.json { render json: @post_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_invitations/1
  # PATCH/PUT /post_invitations/1.json
  def update
    respond_to do |format|
      if @post_invitation.update(post_invitation_params)
        format.html { redirect_to @post_invitation, notice: 'Post invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_invitation }
      else
        format.html { render :edit }
        format.json { render json: @post_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_invitations/1
  # DELETE /post_invitations/1.json
  def destroy
    @post_invitation.destroy
    respond_to do |format|
      format.html { redirect_to post_invitations_url, notice: 'Post invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_invitation
      @post_invitation = PostInvitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_invitation_params
      params.require(:post_invitation).permit(:post_id, :teenager_id)
    end
end
