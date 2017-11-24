class CarsController < ApplicationController
  autocomplete :client, :pseria , :extra_data => [:sname],:extra_data => [:fname],:full => true
  
  def index
   @cars = Car.all
   i = j = 0
   @buz = @dd = []   
   @cars.each do |ca|
      ca.contracts.each do |co|
        @dd[i] = co.order_date.to_s.to_s + ","
        @buz[i] = @buz[i].to_s + co.order_date.to_s[8..9].to_s + ","   
      end
      i += 1
      @buz[i] = ""
   end
  end
  
  def rez
    num = params[:car_num]
    # @car = Car.find(num)  
  end
  
  def contr
    num = params[:car_num]
    @car = Car.find(num)
    @contract = @car.contracts.create
    @client = Client.find(params[:cli_id])   
    if Contract.maximum(:id) != nil then conmax = Contract.maximum(:id) else conmax = 0 end         
    @state = params[:active] || []
    if @state != '1' then     
      @contract.cnum = conmax + 1
      date = params[:nstdate]
      @contract.order_date = date
      @contract.flag = params[:flag] 
      @contract.zalog = params[:zalog]
      @contract.summ = params[:doc_sum]
      @contract.costlei = (params[:doc_sum].to_f * Cparam.last.curs).round(2)
      @contract.garant_summ = params[:garant_summ]
      @contract.diff = params[:enddate]
      @contract.sttime = params[:sttime]
      @contract.endtime = params[:endtime]
      @contract.user = current_user.username
      @contract.client_id = params[:cli_id]
      @contract.save    
    end   
    if @state == '1' then     
      @client = Client.create(params[:contract])
      @client.name = params[:name]
      @client.sname = params[:surname]
      @client.fname = params[:fname]
      @client.pseria = params[:pseria]
      @client.address = params[:address]
      @client.idno = params[:idnp]
      @client.dn = params[:dn]
      @client.de = params[:fname]
      @client.tel = params[:tel]
      @client.pemail = params[:pemail]
      @client.save    
      @contract.cnum = conmax + 1
      date = params[:nstdate]
      @contract.order_date = date
      @contract.flag = 1 
      @contract.diff = params[:enddate]
      @contract.user = current_user.username
      @contract.client_id = @client.id
      @contract.save
   end
  end
  
  def rezdoc
    num = params[:car_num]
    @car = Car.find(num)
    @contract = @car.contracts.create
    @client = Client.find(params[:cli_id]) 
    if Contract.maximum(:id) != nil then conmax = Contract.maximum(:id) else conmax = 0 end      
    @state = params[:active] || []
    if @state != '1'  
      @contract.cnum = conmax + 1
      date = params[:nstdate]
      @contract.order_date = date
      @contract.flag = params[:flag] 
      @contract.zalog = params[:zalog]
      @contract.summ = params[:doc_sum]
      @contract.garant_summ = params[:garant_summ]
      @contract.diff = params[:enddate]
      @contract.sttime = params[:sttime]
      @contract.endtime = params[:endtime]
      @contract.user = current_user.username
      @contract.client_id = params[:cli_id]
      @contract.save  
    end
  end
  
  def reznew
    num = params[:car_num]  
    @car = Car.find(num)
    @contract = @car.contracts.create   
    if Contract.maximum(:id) != nil then conmax = Contract.maximum(:id) else conmax = 0 end     
    @state = params[:active] || []
    if @state != '1'    
      @contract.cnum = conmax + 1
      date = params[:nstdate]
      @contract.order_date = date
      @contract.flag = params[:flag] 
      @contract.zalog = params[:zalog]
      @contract.summ = params[:doc_sum]
      @contract.garant_summ = params[:garant_summ]
      @contract.diff = params[:enddate]
      @contract.sttime = params[:sttime]
      @contract.endtime = params[:endtime]
      @contract.user = current_user.username
      @contract.client_id = params[:cli_id]
      @contract.save   
    end 
    if @state == '1'      
      @client = Client.create(params[:contract])
      @client.name = params[:name]
      @client.sname = params[:surname]
      @client.fname = params[:fname]
      @client.pseria = params[:pseria]
      @client.address = params[:address]
      @client.idno = params[:idnp]
      @client.dn = params[:dn]
      @client.de = params[:fname]
      @client.tel = params[:tel]
      @client.pemail = params[:pemail]
      @client.save 
      @contract.cnum = conmax + 1
      date = params[:nstdate]
      @contract.order_date = date
      @contract.flag = 1
      @contract.diff = params[:enddate]
      @contract.user = current_user.username
      @contract.client_id = @client.id
      @contract.save   
    end   
    redirect_to root_path
  end  
  
  def rez_to_contract
    @contract = Contract.find(params[:contrid]) 
    @contract.flag = 2
    @contract.diff = params[:enddate]
    @contract.endtime = params[:endtime]
    @contract.summ = params[:summ]
    @contract.sttime = params[:sttime]
    @contract.garant_summ = params[:garant_summ]
    @car = @contract.car
    @wl = params[:wlong]
    @car.wlongs.create()
    @wls = @car.wlongs.last
    @wls.wlong = @wl
    @wls.wdate = params[:sttime]
    @wls.save
    @contract.save
    redirect_to root_path
  end
  
  def contract_to_arh
    @contract = Contract.find(params[:contrfid])
    @contract.flag = 3
    @contract.endtime = params[:fendtime]
    @wl_end = params[:wlong_end]
    @car_end = @contract.car
    @wls_end = @car_end.wlongs.create()
    @wls_end.wlong = params[:wlongend]
    @wls_end.wdate = params[:fendtime]
    @wls_end.save
    @contract.save
    redirect_to root_path
  end
  
  def contractnew
   # @car = Car.find(params[:num])
   @carints =  [Array.new(12), Array.new(12),Array.new(12), Array.new(12),Array.new(12), Array.new(12)] 
   i=1
   for i in 1..Car.count
      @carints[i][1] = Car.find(i).int1
      @carints[i][2] = Car.find(i).int1price
      @carints[i][3] = Car.find(i).int2
      @carints[i][4] = Car.find(i).int2price
      @carints[i][5] = Car.find(i).int3
      @carints[i][6] = Car.find(i).int3price
      @carints[i][7] = Car.find(i).int4
      @carints[i][8] = Car.find(i).int4price
      @carints[i][9] = Car.find(i).int5
      @carints[i][10] = Car.find(i).int5price
      @carints[i][11] = Car.find(i).int6
      @carints[i][12] = Car.find(i).int6price
      @carints[i][13] = Car.find(i).int7
      @carints[i][14] = Car.find(i).int7price
   end
   gon.carints = @carints
  end
  
  def show    
    @car = Car.find(params[:id])
  end
  
  def autotech
    @cars = Car.all
  end
 
  def smonth 
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
     #@cars = Contract.select(:car_id).distinct.where("((order_date between ? AND ?) OR (diff between ? AND ?))", @ddateb, @ddatee, @ddateb, @ddatee).order(:car_id)
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
           @contracts = Contract.where("(car_id = ? AND (order_date between ? AND ?) OR (diff between ? AND ?))", caritem.id, @ddateb, @ddatee, @ddateb, @ddatee).order(:order_date)
           report_rind = Array.new((@daycount+3), nil)
           report_rind[0] = i
           report_rind[1] = "#{caritem.marca} #{caritem.gnum}"
           report_rind[@daycount+2] = caritem.id
           if @contracts.count != 0 then    
             @contracts.each do |contritem|
                (1..@daycount).each do |ditem|
                  testdate = @ddateb.change(day: ditem)
                  if (testdate >= contritem.order_date.to_date and testdate <= contritem.diff.to_date) then report_rind[ditem + 1] = contritem.flag end
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
   @contracts = Contract.where("(car_id is not null AND (order_date between ? AND ?) AND flag = 1)", Date.today.beginning_of_day(), Date.today.end_of_day()).order(:car_id)
   if !@contracts.nil? and @contracts.count > 0 then @fl = 1 else @fl = 0 end     
   #---broni-tomorrow---------
   @contracts = Contract.where("(car_id is not null AND (order_date between ? AND ?) AND flag = 1)", Date.tomorrow.beginning_of_day(), Date.tomorrow.end_of_day()).order(:car_id)
   if !@contracts.nil? and @contracts.count > 0 then @fl2 = 1 else @fl2 = 0 end 
   #----contract-today---------
   @contracts = Contract.select(:diff).where("(car_id is not null AND (diff = ?) AND flag = 2)", Date.today.to_formatted_s(:dday_month_year)).order(:car_id)
   if !@contracts.nil? and @contracts.count > 0 then @fl1 = 2 else @fl1 = 0 end 
   #---------------------------       
   #render inline: "<%= @contracts.inspect %><br><br>" 
  end
  
private
 
  def user_params
      params.require(:user).permit(:first_name, :last_name, :other_stuff)
  end 
  
end
