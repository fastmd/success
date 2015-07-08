class ContractsController < ApplicationController
  def create
    @car = Car.find(params[:car_id])
    @contract = @car.contracts.create(params[:contract])
    redurect_to car_path(@car)
  end
  
  def new
    @car = Car.find(params[:car_id])
    @contract = @car.contracts.create(params[:contract])
    redirect_to car_path(@car)
  end
  
end
