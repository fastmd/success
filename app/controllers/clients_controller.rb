class ClientsController < ApplicationController
  
def new
  
end
  
def create
  @client = Client.new(params[:client])
 
  @client.save
  redirect_to clients_path
end
  
  def show
    @client = Client.find(params[:id])
    
  end
  
  def edit
    @client = Client.find(params[:id])
  
  end 
  
   def update
    @client = Client.find(params[:id])
        if @client.update(params[:client])
        redirect_to clients_path
    else
      render 'edit'
    end
  end  
  
  
  def index
    @clients = Client.all
  end
end
