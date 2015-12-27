class HomeController < ApplicationController
  def raffle
    @client=Client.new
  end

  def raffleEnter
    @client = Client.new(client_params)
    @client.save

  end
  def client_params
   params.require(:client).permit(:name, :email)
  end
end
