class WlongsController < ApplicationController
  
  def create
    @car = Car.find(params[:car_id])
    @wlong = @car.wlongs.create(params[:wlong])
    redirect_to car_path(@car)
  end
  
end
