class TehservicesController < ApplicationController
  before_action :redirect_cancel , only: [:create, :update]
  
  def index
    @car = Car.find(params[:car_id])
    @tehservices = @car.tehservices.all
  end
  
  def new 
    @tehservice = Tehservice.new
    @tehservice.user_id = current_user.id 
    @tehservice.car_id = params[:car_id]
    @tehservice.sdate =  Time.zone.now
    @tehservice.stype =  1
    #render inline: "<%= @tehservice.inspect %><br><br>" and return
  end
  
  def create
    @tehservice = Tehservice.new(tehservice_params)
    @tehservice = tehservice_init(@tehservice)
    @flag = 0
    unless params[:parcurs].nil? then
      if Wlong.where("(car_id = ? AND wdate = ?)", @tehservice.car_id, @tehservice.sdate).count != 0 then 
        @wlong = Wlong.where("(car_id = ? AND wdate = ?)", @tehservice.car_id, @tehservice.sdate).last 
      else
        @wlong = Wlong.new
      end
      @wlong = wlong_init(@wlong)    
      wlong_save 
      #render inline: "<%= @wlong.inspect %><br><br><%= @tehservice.inspect %><br><br><%= @flag.inspect %><br><br>" and return         
    end     
    tehservice_save
    if @flag == 1 then
      redirect_to tehservices_index_path(:car_id => @tehservice.car_id) 
    else
      render 'new' 
    end     
  end

private
  def tehservice_params
    params.require(:tehservice).permit(:car_id,:user_id,:sdate,:sttime,:stype,:sprice,:comments)
  end
  
  def tehservice_init(tehservice)
    tehservice.user_id = tehservice_params[:user_id]
    tehservice.car_id = params[:car_id]
    tehservice.stype = params[:stype]
    tehservice.sprice = tehservice_params[:sprice]
    tehservice.comments = tehservice_params[:comments]
    # stdate
    if params[:sdate] then
      d = (params[:sdate]).to_datetime 
      unless (tehservice_params['sttime(4i)'].nil?) then d = d.change(hour: tehservice_params['sttime(4i)'].to_i) end
      unless (tehservice_params['sttime(5i)'].nil?) then d = d.change(min: tehservice_params['sttime(5i)'].to_i) end  
      tehservice.sdate = d
    end    
    tehservice    
  end
  
  def tehservice_save
    @flag = 0
    t = Tehservice.where("(car_id = ? AND sdate = ?)", @tehservice.car_id, @tehservice.sdate).count
    c = Tehservice.where("(car_id = ? AND sdate = ?)", @tehservice.car_id, @tehservice.sdate).last                      
    if (t != 0) then
      flash[:warning] = "ТО № #{c.id} #{c.sdate} уже существует. Проверьте правильность ввода."        
    else
      begin
        if @tehservice.save! then 
          flash.discard
          flash[:notice] = "ТО № #{@tehservice.id} #{@tehservice.sdate} сохранено."
          @flag = 1         
        end
      rescue
        flash[:warning] = "Данные не сохранены. Проверьте правильность ввода. Обязательные поля: дата, время, цена."             
      end
    end      
  end  
  
  def wlong_init(wlong)
    wlong.parcurs = params[:parcurs]
    wlong.car_id = params[:car_id]
    d = (params[:sdate]).to_datetime 
    unless (tehservice_params['sttime(4i)'].nil?) then d = d.change(hour: tehservice_params['sttime(4i)'].to_i) end
    unless (tehservice_params['sttime(5i)'].nil?) then d = d.change(min: tehservice_params['sttime(5i)'].to_i) end  
    wlong.wdate = d
    wlong    
  end
  
  def wlong_save
      begin
        if @wlong.save! then 
          @flag = 1         
        end
      rescue
        flash[:warning] = "Пробег не сохранен. Проверьте правильность ввода."             
      end    
  end
  
  def redirect_cancel
    if params[:cancel] then
      flash.discard 
      redirect_to cars_autotech_path
    end   
  end 
  
end
