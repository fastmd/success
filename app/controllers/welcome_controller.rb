class WelcomeController < ApplicationController
  def index
    @cars = Car.all
    i = 0;
    j = 0;
    @buz = []
     @cars.each do |ca|
      ca.contracts.each do |co|
      @buz[i] = co.order_date.to_s[5..6].to_i 
      i = i + 1  
    end
    end
  end
end
