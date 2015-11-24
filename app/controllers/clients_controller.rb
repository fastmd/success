class ClientsController < ApplicationController
  
   def create
    @client = Client.create(params[:contract])
    redirect_to clients_path
  end
  
  def new
    @client = Client.create(params[:contract])
    redirect_to clients_path
  end
  
  def show
    @client = Client.find(params[:id])
    
  end
  
  
  def index
    @clients = Client.all
  end
end
