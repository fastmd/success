class CparamsController < ApplicationController
  
  def show
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
  
end
