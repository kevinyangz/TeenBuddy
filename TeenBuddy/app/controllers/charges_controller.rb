class ChargesController < ApplicationController
  def index
    if current_user.teenager
      @teenager = current_user.teenager
      @state = 'teenager'
    elsif current_user.client
      @client = current_user.client
      @state = 'client'
    end
  end

  def new
  end

  def create
    # Amount in cents
    @amount = params[:credit]
    #@amount = @amount*100.0
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

    if charge 
        if current_user.teenager
          @teenager = current_user.teenager
          @teenager.available_credit = @teenager.available_credit + @amount.to_i
          @teenager.save
        elsif current_user.client
          @client = current_user.client
          @client.available_credit = @client.available_credit + @amount.to_i
          @client.save
        end
        #render :index
    end 

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
  end

end
