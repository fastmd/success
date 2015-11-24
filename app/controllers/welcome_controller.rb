class WelcomeController < ApplicationController
  def index
    @cars = Car.all
    i = 0;
    j = 0;
    @buz = []
     @cars.each do |ca|
      ca.contracts.each do |co|
      @buz[i] = @buz[i].to_s + co.order_date.to_s[8..9].to_s + ","   
    end
    i = i + 1
    @buz[i] = ""
    end
  end
end
