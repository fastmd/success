class CarsController < ApplicationController
  def index
    @cars = Car.all
    i = 0;
    j = 0;
    @buz = []
    @cars.each do |ca|
      ca.contracts.each do |co|
      @buz[i] = j.to_s + co.order_date.to_s[5..6].to_s 
      i = i + 1  
    end
      j = j + 1
    end
    @buz = [3,4,5, 10,11,12,23,25,28]
  end
  
  def show    
    @car = Car.find(params[:id])
  end
  
end
