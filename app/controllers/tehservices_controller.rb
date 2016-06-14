class TehservicesController < ApplicationController
  
    def new
      
     end
     
    def newto  
      
    if @car != nil 
      @car = Car.find(params[:num])
    else
      @car = Car.find(params[:car_num])  
    end  
    
    @tehservice = @car.tehservices.create
    @wlong = @car.wlongs.new
    
    @tehservice.stype = params[:stype]
    @tehservice.sprice = params[:sprice]
    @tehservice.sdate = params[:sdate]
    @tehservice.comments = params[:comments]
    @tehservice.save
    
    @wlong.wdate = params[:sdate]
    @wlong.wlong = params[:wlong]
    @wlong.tehservice_id = @tehservice.id
    @wlong.save
    redirect_to car_autotech_path
  end
  
    def list
      @car = Car.find(params[:num])
    end
  
end
