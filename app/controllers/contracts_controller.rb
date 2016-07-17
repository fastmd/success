class ContractsController < ApplicationController
  def create
    @car = Car.find(params[:car_id])
    @contract = @car.contracts.create(params[:contract])
    redirect_to car_path(@car)
  end
  
  def new
    @car = Car.find(params[:car_id])
    @contract = @car.contracts.create(params[:contract])
    redirect_to contract_path(@contract.id)
  end
  
  def edit
    @cli = Client.find(params[:id])
  end
  
  def show
    
    @contract = Contract.find(params[:id])
    
    @car = @contract.car
    
    @client = @contract.client
    
    mmail = "octa_c@moldelectrica.md;sergelus@yandex.ru"
    #Usernot.send_email(mmail,@contract.id).deliver
    


    @contract.id do |format|
    format.html # show.html.erb
    format.xml { render :xml => @item }
    
    format.pdf do
        render :pdf => 'Coming soon...', :layout => false
    end
  end

  end
  
  
      

  
end
