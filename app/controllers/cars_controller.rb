class CarsController < ApplicationController
  autocomplete :client, :pseria , :extra_data => [:sname],:extra_data => [:fname],:full => true
  before_action :redirect_cancel, only: [:create, :update]
  
 def index
   @cars = Car.all.order(:marca,:gnum)
 end
  
 def new
 end
  
 def create
  @car = Car.new(car_params)
  @car = car_init(@car)
  car_save
  if @flag == 1 then
    redirect_to cars_index_path
  else
    render 'new'     
  end 
  #render inline: "<%= @car.inspect %><br><br>"     
 end
 
 def edit
  @car = Car.find(params[:id])
 end 
  
 def update  
    @car = Car.find(params[:id])
    @car = car_init(@car)
    car_save
    if @flag == 1 then
      redirect_to cars_index_path
    else
      render 'edit'
    end
 end
 
 def destroy
    car = Car.find(params[:id])
    ss_count = car.contracts.count
    if ss_count!=0 then 
      flash[:warning] = "Нельзя удалить авто #{car.id} #{car.marca} #{car.gnum}, для которого существуют контракты (#{ss_count} шт.)" 
    else 
      begin
        if car.destroy! then 
          flash.discard
          flash[:notice] = "Авто #{car.marca} #{car.gnum} удалено."         
        end
      rescue
        flash[:warning] = "Не удалось удалить авто #{car.marca} #{car.gnum}."             
      end
    end
    redirect_to cars_index_path
  end  
  
  def show    
    @car = Car.find(params[:id])
  end
  
  def autotech
    @cars = Car.all
  end
 
  def smonth
  filtertocookies
  cookiesforreports    
   #---search------------ 
   if params[:filter] then
      @qmarca = params[:qmarca].to_s
      @data_for_search = ''
    else
        if params[:search] then
            @data_for_search = params[:q].to_s
            @qmarca = ''           
        else
            @data_for_search = ''
        end
        @qmarca = ''   
    end 
   @fmarcas = Car.select(:marca).distinct.order(:marca).pluck(:marca) 
   #---month------------ 
   @year = Date.today.year.to_i
   @month = Date.today.month.to_i
   @day = Date.today.day.to_i
   #--------------------
   @mn = @month
   @currentdate = Date.today.change(day: 1)  
   #----12-month-beg---------------
   @months = Array[]
   @title1 = Array[]
   @report1 = Array[]
   perioddateb = Date.today.change(day: 1) - 6.month      #begin of the period
   (1..12).each do |monthitem|
     @ddateb = perioddateb + monthitem.month             #begin of the month
     @ddatee = @ddateb + 1.month - 1.day                 #end of the month 
     @daycount = (@ddatee - @ddateb + 1).to_i            #number of days between report dates   
     #------------
     @title = Array[]
     report_rind = Array.new((@daycount+2), nil)
     (1..@daycount).each do |ditem|
         testdate = @ddateb.change(day: ditem)
         if (testdate.wday == 6 or testdate.wday == 0) then report_rind[ditem + 1] = 1 end
         if (testdate == Date.today) then report_rind[ditem + 1] = 2 end  
     end 
     @title = report_rind[0..(@daycount+2)]  
     #------------
     #@cars = Contract.select(:car_id).distinct.where("((stdate between ? AND ?) OR (enddate between ? AND ?))", @ddateb, @ddatee, @ddateb, @ddatee).order(:car_id)
     if (@data_for_search.nil? or @data_for_search.empty?) then
       if (@qmarca.nil? or @qmarca.empty?) then
         @filter = 0
         @cars = Car.all.order(:marca,:id)
       else
         @filter = 1 
         @cars = Car.where("( marca = ? )", @qmarca).order(:marca,:id) 
       end
     else
       @filter = 1
       data_for_search = "%" + @data_for_search + "%" 
       @cars = Car.where("( marca like ? )", data_for_search).order(:marca,:id)   
     end
    # @cars = Car.all.order(:marca,:id)
     @report = Array[]
     i = 1
     if @cars.count != 0 then
        @cars.each do |caritem|
           @contracts = Contract.where("(car_id = ? AND ((stdate between ? AND ?) OR (enddate between ? AND ?)))", caritem.id, @ddateb, @ddatee, @ddateb, @ddatee).order(:order_date)
           report_rind = Array.new((@daycount+3), nil)
           report_rind[0] = i
           report_rind[1] = "#{caritem.marca} #{caritem.gnum}"
           report_rind[@daycount+2] = caritem.id
           if @contracts.count != 0 then    
             @contracts.each do |contritem|
                (1..@daycount).each do |ditem|
                  testdate = @ddateb.change(day: ditem)
                  #if (testdate >= contritem.order_date.to_date and testdate <= contritem.diff.to_date) then report_rind[ditem + 1] = contritem.flag end
                  if (testdate >= contritem.stdate.to_date and testdate <= contritem.enddate.to_date) then 
                    report_rind[ditem + 1] = {:flag => contritem.flag, 
                                              :client => " #{contritem.client.sname} #{contritem.client.name} #{contritem.client.fname}",
                                              :contract_id => contritem.id, 
                                              :contract => " № #{contritem.id}/#{contritem.cnum} от #{contritem.order_date.to_date.to_formatted_s(:dday_month_year)}" +
                                              unless contritem.stdate.nil? then " с #{contritem.stdate.to_formatted_s(:dday_month_year)}" else "" end +  
                                              unless contritem.sttime.nil? then " #{contritem.sttime.strftime('%R')}" else "" end + 
                                              unless contritem.enddate.nil? then " по #{contritem.enddate.to_date.to_formatted_s(:dday_month_year)}" else "" end + 
                                              unless contritem.endtime.nil? then " #{contritem.endtime.strftime('%R')}" else "" end} 
                  end  
                end    
             end
           end  
           @report << report_rind[0..(@daycount+3)] 
           i += 1 
       end # cars.each
     end # if cars.count
     @title1[monthitem-1] = @title
     @report1[monthitem-1] = @report
     @months[monthitem-1] = @ddateb
     #-----------
   end  #1..12
   #----12-month-end---------------
   #-----------      
   @cars = Car.all.order(:marca,:id)
   #---broni-today---------        
   @broni_today = Contract.where("(car_id is not null AND (stdate <= ?) AND flag = 1)", Date.today).order(:car_id)
   if !@broni_today.nil? and @broni_today.count > 0 then @fl = 1 else @fl = 0 end     
   #---broni-tomorrow---------
   @broni_tomorrow = Contract.where("(car_id is not null AND (stdate between ? AND ?) AND flag = 1)", Date.tomorrow, Date.tomorrow).order(:car_id)
   if !@broni_tomorrow.nil? and @broni_tomorrow.count > 0 then @fl2 = 1 else @fl2 = 0 end 
   #----contract-today---------
   @contracts_close_today = Contract.where("(car_id is not null AND (enddate <= ?) AND flag = 2)", Date.today).order(:car_id)
   if !@contracts_close_today.nil? and @contracts_close_today.count > 0 then @fl1 = 2 else @fl1 = 0 end 
   #---------------------------      
   #render inline: "<%= @report1.inspect %><br><br>" 
  end
  
private
 
  def user_params
      params.require(:user).permit(:first_name, :last_name, :other_stuff)
  end
   
  def car_params
    params.require(:car).permit(:marca,:gnum,:cuznum,:motnum,:proddate,:color,:vmot,:tmasa,:tsumm,:aprod,:capcil,:int1,:int1price,:int2,:int2price,:int3,:int3price,
                                :int4,:int4price,:int5,:int5price,:int6,:int6price,:int7,:int7price, :gaj)
  end
  
  def car_init(car)
    car.marca = unless car_params[:marca].nil? then (car_params[:marca]).lstrip.rstrip else nil end
    car.gnum = unless car_params[:gnum].nil? then (car_params[:gnum]).lstrip.rstrip.upcase else nil end
    car.cuznum = unless car_params[:cuznum].nil? then (car_params[:cuznum]).lstrip.rstrip.upcase else nil end     
    car.motnum = unless car_params[:motnum].nil? then (car_params[:motnum]).lstrip.rstrip.upcase else nil end
    car.proddate = unless car_params[:proddate].nil? then car_params[:proddate] else nil end  
    car.color = unless car_params[:color].nil? then car_params[:color] else nil end
    car.vmot = car_params[:vmot]
    car.tmasa = car_params[:tmasa]
    car.tsumm = car_params[:tsumm]
    car.aprod = car_params[:aprod]
    car.capcil = car_params[:capcil]
    car.int1 = car_params[:int1]
    car.int1price = car_params[:int1price]
    car.int2 = car_params[:int2]
    car.int2price = car_params[:int2price]
    car.int3 = car_params[:int3]
    car.int3price = car_params[:int3price]
    car.int4 = car_params[:int4]
    car.int4price = car_params[:int4price]
    car.int5 = car_params[:int5]
    car.int5price = car_params[:int5price]
    car.int6 = car_params[:int6]
    car.int6price = car_params[:int6price]
    car.int7 = car_params[:int7]
    car.int7price = car_params[:int7price]
    car.gaj = car_params[:gaj]
    car    
  end
  
  def car_save
    @flag = 0
    t = Car.where("(? is null or id !=?) and UPPER(gnum) = ?", @car.id, @car.id, (@car.gnum).upcase).count
    c = Car.where("(? is null or id !=?) and UPPER(gnum) = ?", @car.id, @car.id, (@car.gnum).upcase).last                      
    if (t != 0) then
      flash[:warning] = "Авто № #{c.id} #{c.marca} #{c.gnum} уже существует. Проверьте правильность ввода."        
    else
      begin
        if @car.save! then 
          flash.discard
          flash[:notice] = "Авто #{@car.marca} #{@car.gnum} сохранено."
          @flag = 1         
        end
      rescue
        flash[:warning] = "Данные не сохранены. Проверьте правильность ввода. Обязательные поля: марка, гос.номер, залог, дни1, цена1."             
      end
    end      
  end
  
  def redirect_cancel
    if params[:cancel] then
      flash.discard 
      redirect_to cars_index_path
    end   
  end 
  
       
  def filtertocookies
    if params[:filter] then
        cookies[:qсar] = @qсar = params[:qсar].to_s
        @data_for_search = ''
        cookies.delete(:data_for_search) 
    else
        if params[:search] then
            cookies[:data_for_search] = @data_for_search = params[:q].to_s
            cookies.delete(:qсar)            
        else
            @data_for_search = cookies[:data_for_search]
        end
        @qсar = cookies[:qсar]
    end     
   end 
   
   def cookiesforreports
    # filter
    @data_for_search = cookies[:data_for_search]
    @qсar = cookies[:qсar]
  end    
    
end
