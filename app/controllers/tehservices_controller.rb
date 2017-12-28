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
    @tehservice.sdate =  Time.current
    @tehservice.stype =  1
    #render inline: "<%= @tehservice.inspect %><br><br>" and return
  end
  
  def create
    #render inline: "<%= params.inspect %><br><br>" and return
    if tehservice_params[:id] then
      @tehservice = Tehservice.find(tehservice_params[:id])
    else
      @tehservice = Tehservice.new(tehservice_params)        
    end
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
      if tehservice_params[:id] then render 'edit' else render 'new' end 
    end     
  end
  
  def edit
    @tehservice = Tehservice.find(params[:id])
    @wlong = Wlong.where("(car_id = ? AND wdate is not null AND wdate = ?)", @tehservice.car_id, @tehservice.sdate).last
    if @wlong then @parcurs = @wlong.parcurs end
    #render inline: "<%= @tehservice.inspect %><br><br><%= @wlong.inspect %><br><br>" and return    
  end
  
  def destroy
    tehservice = Tehservice.find(params[:id])
      begin
        if tehservice.destroy! then 
          flash.discard
          flash[:notice] = "ТО № #{tehservice.id} от #{tehservice.sdate.strftime('%d.%m.%Y %R')} удалено."         
        end
      rescue
        flash[:warning] = "Не удалось удалить ТО № #{tehservice.id} от #{tehservice.sdate.strftime('%d.%m.%Y %R')}."             
      end
    redirect_to tehservices_index_path(:car_id => tehservice.car_id)
  end 

  def update  
    @tehservice = Tehservice.find(params[:id])
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
    #render inline: "<%= @wlong.inspect %><br><br><%= @tehservice.inspect %><br><br><%= @flag.inspect %><br><br>" and return           
    tehservice_save
    if @flag == 1 then
      redirect_to tehservices_index_path
    else
      render 'edit'
    end
  end

private
  def tehservice_params
    params.require(:tehservice).permit(:car_id,:user_id,:sdate,:sttime,:stype,:sprice,:comments,:id)
  end
  
  def tehservice_init(tehservice)
    tehservice.id = tehservice_params[:id]
    tehservice.user_id = tehservice_params[:user_id]
    tehservice.car_id = params[:car_id]
    tehservice.stype = params[:stype]
    tehservice.sprice = tehservice_params[:sprice]
    tehservice.comments = tehservice_params[:comments]
    # stdate
    if params[:sdate] then
      d = (params[:sdate]).to_datetime.in_time_zone 
      unless (tehservice_params['sttime(4i)'].nil?) then d = d.change(hour: tehservice_params['sttime(4i)'].to_i) end
      unless (tehservice_params['sttime(5i)'].nil?) then d = d.change(min: tehservice_params['sttime(5i)'].to_i) end  
      tehservice.sdate = d
    end    
    tehservice    
  end
  
  def tehservice_save
    @flag = 0
    @parcurs = params[:parcurs]
    t = Tehservice.where("(car_id = ? AND sdate = ?)", @tehservice.car_id, @tehservice.sdate).count
    c = Tehservice.where("(car_id = ? AND sdate = ?)", @tehservice.car_id, @tehservice.sdate).last                      
    if (t != 0 and !@tehservice.id) then
      flash[:warning] = "ТО № #{c.id} от #{c.sdate.strftime('%d.%m.%Y %R')} уже существует. Проверьте правильность ввода."        
    else
      begin
        if @tehservice.save! then 
          flash.discard
          flash[:notice] = "ТО № #{@tehservice.id} от #{@tehservice.sdate.strftime('%d.%m.%Y %R')} сохранено."
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
    d = (params[:sdate]).to_datetime.in_time_zone 
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
      if tehservice_params[:id] then redirect_to tehservices_index_path(:car_id => params[:car_id]) else redirect_to cars_autotech_path end 
    end   
  end 
  
end
