class ChargesController < ApplicationController
  before_action :authenticate_user!

  def index
   @transactions = Transaction.where(user:current_user).order(created_at: :desc);
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
      @transaction = Transaction.new(user: current_user, inout: true, comment: 'Deposit (We charge 5% service fee.)', amount: (@amount.to_i)*0.95)
      @transaction.save
      redirect_to charges_path, notice:"Thanks, you have successfully deposited $#{(@amount*0.95)/100.0}"
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end


end
