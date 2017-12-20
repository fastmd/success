class CparamsController < ApplicationController
  before_action :redirect_cancel, only: [:create, :update]
  
  def show
   @rates = Cparam.where("created_at >= ?", 3.month.ago.to_date).order(:created_at) 
   gon.rates = @rates
   #---curs------------- 
   @cparam = Cparam.last    
  end
  
  def new
    @cpar = Cparams.new
  end
  
  def create
    @cpar = Cparam.new(cparam_params)
    @cpar.save
    redirect_to root_path
  end
  
private
  def cparam_params
    params.require(:cparam).permit(:curs)
  end
  
  def redirect_cancel
    if params[:cancel] then
      flash.discard 
      redirect_to cars_smonth_path
    end   
  end      
  
end
