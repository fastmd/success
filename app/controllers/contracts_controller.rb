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
      @carints =  [Array.new(12), Array.new(12),Array.new(12), Array.new(12),Array.new(12), Array.new(12)] 
   i=1
   for i in 1..Car.count
    @carints[i][1] = Car.find(i).int1
    @carints[i][2] = Car.find(i).int1price
    @carints[i][3] = Car.find(i).int2
    @carints[i][4] = Car.find(i).int2price
    @carints[i][5] = Car.find(i).int3
    @carints[i][6] = Car.find(i).int3price
    @carints[i][7] = Car.find(i).int4
    @carints[i][8] = Car.find(i).int4price
    @carints[i][9] = Car.find(i).int5
    @carints[i][10] = Car.find(i).int5price
    @carints[i][11] = Car.find(i).int6
    @carints[i][12] = Car.find(i).int6price
    @carints[i][13] = Car.find(i).int7
    @carints[i][14] = Car.find(i).int7price
   end
   gon.carints = @carints
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
