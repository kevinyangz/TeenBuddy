class ChargesController < ApplicationController
  def index
    @amount = 0    #in cents
    
    if current_user.teenager
      @teenager = current_user.teenager
    elsif current_user.client
      @client = current_user.client
    end

  end

  def new
    @amount = 0
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'cad'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
