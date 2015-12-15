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
  
  def show
    @contract = Contract.find(params[:id])
    @car = Car.find(@contract.car_id)
    @contract.id do |format|
    format.html # show.html.erb
    format.xml { render :xml => @item }
    format.msword { set_header('doc', "#{@item.title}.doc") }
    format.doc { set_header('doc', "#{@item.title}.doc") }
    format.pdf do
        render :pdf => 'Coming soon...', :layout => false
    end
  end

  end
  
      

  
end
