class HomeController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:stripe]

  def raffle
    @client=Client.new
  end

  def raffleEnter
    @client = Client.new(client_params)
    @client.save

  end

  def getOneFree
  end
  def stripe
    Stripe.api_key = "sk_test_wwNvD8PnMfUPqRgxGUONFsQ4"

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => 1000, # amount in cents, again
        :currency => "usd",
        :source => token,
        :description => "Example charge"
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end
  end

  def client_params
   params.require(:client).permit(:name, :email)
  end
end
