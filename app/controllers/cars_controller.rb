class CarsController < ApplicationController
  autocomplete :client, :sname
  
  def index
   @cars = Car.all
    i = 0;
    j = 0;
    @buz = []
    @dd = []
     @cars.each do |ca|
      ca.contracts.each do |co|
        @dd[i] = co.order_date.to_s.to_s + ","
        @buz[i] = @buz[i].to_s + co.order_date.to_s[8..9].to_s + ","   
    end
    i = i + 1
    @buz[i] = ""
    end
  end
  
  def rez
   @car = Car.find(1.to_i)
    
  end
  
  def reznew
    num = params[:car_num]
    @car = Car.find(num)
    @contract = @car.contracts.create
    @contract.cnum = Contract.maximum(:id) + 1
    date = params[:nstdate]
    @contract.order_date = date 
    @contract.diff = params[:enddate]
    @contract.save
    redirect_to root_path
  end  
  def contractnew
    @car = Car.find(params[:num])
  end
  
  def show    
    @car = Car.find(params[:id])
  end
 
  def smonth
    
    if params[:num]
        mnum = params[:num]
    else
        mnum = 11
    end 
    if (mnum.to_i % 2)
      @daycount = 31
    else
      @daycount = 30
    end
        
    @cars = Car.all
    i = 0;
    j = 0;
    
    @mn = mnum
    @buz = []
    @buz1 = []
    @dd = []
     @cars.each do |ca|
      ca.contracts.each do |co|
        mon = co.order_date.to_s[5..6]
        if mon.to_i == mnum.to_i  
          @dd[i] = co.order_date.to_s.to_s + ","
          stdate = co.order_date.to_s[8..9].to_i
          @buz[i] = co.order_date.to_s[8..9].to_s
          diff = (co.diff.to_s[0..1].to_i+1) - stdate    
          @buz1[i] = diff.to_s
        end     
    end
    i = i + 1
    @buz[i] = ""
    end
  end
  
end
