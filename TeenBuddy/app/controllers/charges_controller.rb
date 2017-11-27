class ChargesController < ApplicationController
  before_action :authenticate_user!

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
    @amount = params[:credit].to_i*100

    if !@amount || @amount <= 0
      puts 'amount'
      puts @amount
      flash[:error] = 'Please Enter a valid amount!'
      redirect_to charges_path
    end


    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        :customer => customer.id,
        :amount => @amount,
        :description => 'Rails Stripe customer',
        :currency => 'cad'
    )

    if charge
      @transaction = Transaction.new(user: current_user, inout: true, comment: 'Deposit with amount ', amount: @amount.to_i)
      @transaction.save
      redirect_to charges_path, notice:"Thanks, you have successfully deposited $#{@amount/100.0}"
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end


end
