class ContractsController < ApplicationController
  before_action :redirect_cancel #, only: [:create, :update]
  
  def index
    filtertocookies
    cookiesforreports
    if (@qсar.nil? or @qсar.empty?)
      @contracts = Contract.where("(flag = 2)").order(:order_date)
    else
      @contracts = Contract.where("(flag = 2 and car_id = ?)", @qсar).order(:order_date)
    end    
  end
  
  def indexbroni
    filtertocookies
    cookiesforreports    
    @contracts = Contract.where("(flag = 1)").order(:order_date)
  end
  
  def indexarc
    filtertocookies
    cookiesforreports    
    @contracts = Contract.where("(flag not in (1,2) )").order(:order_date)
  end  
  
  def create
    @contract = Contract.new(contract_params)
    @contract = contract_init(@contract)
    unless params[:active].nil? then
      @client = Client.new(client_params)
      @client = client_init(@client)
      client_save
      @contract.client_id = @client.id        
    end 
    contract_save
    if @flag == 1 then
      if params[:printfromedit] then  redirect_to contracts_show_path(:id => @contract.id, format: "pdf") and return end
      if params[:va] == 'newbroni'  then 
        redirect_to contracts_indexbroni_path 
      else 
        redirect_to contracts_path 
      end
    else
      if params[:va] == 'newbroni'  then render 'newbroni'  else  render 'new' end  
    end 
    #render inline: "<%= params.inspect %><br><br>"
  end
     
  def update
    #render inline: "<%= params.inspect %><br><br>" and return  
    @contract = Contract.find(params[:id])
    @contract = contract_init(@contract)
    contract_save
    if @flag == 1 then
      if params[:printfromedit] then  redirect_to contracts_show_path(:id => @contract.id, format: "pdf") and return end
      if @contract.flag == 1 then 
        redirect_to contracts_indexbroni_path 
      else 
        redirect_to contracts_path 
      end
    else
      render 'edit'
    end
  end
  
  def destroy
    contract = Contract.find(params[:id])
    if contract.nil? then 
      flash[:warning] = "Нельзя удалить несуществующий объект" 
    else 
      begin
        if contract.destroy! then 
          flash.discard
          flash[:notice] = if contract.flag == 2 then "Контракт № #{contract.id}/#{contract.cnum} от #{contract.order_date.strftime('%d.%m.%Y')} удален." 
                           else "Бронь № #{contract.id}/#{contract.cnum} от #{contract.order_date.strftime('%d.%m.%Y')} удалена."end          
        end
      rescue
        flash[:warning] = if contract.flag == 2 then "Не удалось удалить контракт #{contract.id}/#{contract.cnum} от #{contract.order_date.strftime('%d.%m.%Y')}."
                          else "Не удалось удалить бронь #{contract.id}/#{contract.cnum} от #{contract.order_date.strftime('%d.%m.%Y')}." end              
      end
    end    
    if contract.flag == 1 then redirect_to contracts_indexbroni_path else redirect_to contracts_path end 
  end  
   
  def new
   gon.cars = Car.all
   @contract = Contract.new
   @contract.client_id = params[:client_id]
   @contract.car_id = params[:car_id]
   @contract.order_date =  Date.today
   @contract.stdate =  Date.today
   d = @contract.stdate + 1.day
   @contract.enddate = d   
   @contract.dperiod = 1
   @contract.user_id = current_user.id
   @contract.flag = 2
   @contract.curs = Cparam.last.curs ? Cparam.last.curs : 1
   unless @contract.car_id.nil? then
     @contract.price = @contract.car.int1price   # price     
     @contract.zalog = @contract.car.gaj     # zalog 
     @contract.garant_summ = @contract.car.gaj         # задаток 
   end
   @pretperday = @contract.price.to_i
   @daysinperiod = @contract.dperiod
   # suma valuta
   @contract.summ = (@contract.price.to_i * @contract.dperiod).round(2) 
   # suma lei 
   @contract.costlei = ((@contract.price.to_i * @contract.dperiod).round(2) * @contract.curs.to_i).round(2)       
   #render inline: "<%= @contract.inspect %><br><br>"  
  end
  
  def newbroni
   gon.cars = Car.all 
   @contract = Contract.new
   @contract.client_id = params[:client_id]
   @contract.car_id = params[:car_id]
   @contract.stdate = params[:stdate] ?  params[:stdate] : Date.today
   d = @contract.stdate + 1.day
   @contract.enddate = d
   @contract.dperiod = 1
   @contract.order_date =  Date.today
   @contract.user_id = current_user.id   
   @contract.flag = 1
   unless @contract.car_id.nil? then
     @contract.price = @contract.car.int1price   # price     
     @contract.garant_summ = @contract.car.gaj         # задаток    
   end  
  # render inline: "<%= params.inspect %><br><br>"  
  end
    
  def edit
    gon.cars = Car.all
    @contract = Contract.find(params[:id])
  end
  
  def show    
    @contract = Contract.find(params[:id])
    @car = @contract.car
    @client = @contract.client
    @daysinperiod = @contract.dperiod ? @contract.dperiod : (@contract.enddate - @contract.stdate).to_i   #number of days between report dates
    if @daysinperiod < 1 then @daysinperiod = 1 end
    @pretperday = @contract.price ? @contract.price : ( @contract.summ.to_i / @daysinperiod).round(2)   #pret 
    respond_to do |format|
        format.html
        if @contract.flag == 1 then 
           format.pdf { send_data BronareReport.new.to_pdf(@contract,@car,@client), :type => 'application/pdf', :filename => "bronare_#{@car.marca}_#{@contract.id}_#{@contract.cnum}.pdf" }
        else
           format.pdf { send_data ContractReport.new.to_pdf(@contract,@car,@client), :type => 'application/pdf', :filename => "contract_#{@car.marca}_#{@contract.id}_#{@contract.cnum}.pdf" }  
        end
    end
  end
  
  def broni2contract
    @contract = Contract.find(params[:id])
    # пробег
    @car = @contract.car
    @car.wlongs.create()
    @wls = @car.wlongs.last
    @wls.wlong = params[:wlong]
    @wls.wdate = @contract.stdate.strftime("%d.%m.%Y")
    @wls.save
    # contract
    @contract.flag = 2
    # агент
    if @contract.user.nil? then @contract.user_id = current_user.id end
    # время начала и конца  
    @contract.endtime = Time.parse(Time.now.strftime('%R'))
    @contract.sttime = Time.parse(Time.now.strftime('%R'))
    # zalog
    @contract.zalog = @car.gaj
    # days in period
    @daysinperiod = @contract.dperiod ? @contract.dperiod : (@contract.enddate - @contract.stdate).to_i   #number of days between report dates
    if @daysinperiod < 0 then @daysinperiod = 0 end
    @contract.dperiod = @daysinperiod
    # curs
    @curs = Cparam.last.curs ? Cparam.last.curs : 1
    @contract.curs = @curs
    # price
    if @contract.price.nil? then
      f = nil
      @pretperday = 0 
      if (!@car.int1.nil? and !@car.int1price.nil? and f.nil?) then 
        @pretperday = @car.int1price
        if (@daysinperiod <= @car.int1) then f = 1 end 
      end
      if (!@car.int2.nil? and !@car.int2price.nil? and f.nil?) then 
        @pretperday = @car.int2price
        if (@daysinperiod <= @car.int2) then f = 1 end  
      end
      if (!@car.int3.nil? and !@car.int3price.nil? and f.nil?) then 
        @pretperday = @car.int3price
        if (@daysinperiod <= @car.int3) then f = 1 end  
      end
      if (!@car.int4.nil? and !@car.int4price.nil? and f.nil?) then  
        @pretperday = @car.int4price
        if (@daysinperiod <= @car.int4) then f = 1 end  
      end
      if (!@car.int5.nil? and !@car.int5price.nil? and f.nil?) then 
        @pretperday = @car.int5price
        if (@daysinperiod <= @car.int5) then f = 1 end  
      end
      if (!@car.int6.nil? and !@car.int6price.nil? and f.nil?) then 
        @pretperday = @car.int6price
        if (@daysinperiod <= @car.int6) then f = 1 end  
      end                 
      @contract.price = @pretperday     #pret   
    else
      @pretperday = @contract.price.to_i
    end 
    # suma valuta
    @summ = (@pretperday * @daysinperiod).round(2) 
    @contract.summ = @summ
    # suma lei 
    @contract.costlei = ((@pretperday * @daysinperiod).round(2) * @curs).round(2)
    render "edit"      
  end
  
  def contract2arh
    # contract
    @contract = Contract.find(params[:id])
    @contract.flag = 3
    @contract.fendtime = "#{params[:contract]['fendtime(4i)']}:#{params[:contract]['fendtime(5i)']}"
    if @contract.user.nil? then @contract.user_id = current_user.id end
    contract_save
    # пробег
    @car = @contract.car
    @wls_end = @car.wlongs.create()
    @wls_end.wlong = params[:contract][:wlongend]
    @wls_end.wdate = @contract.enddate.strftime("%d.%m.%Y")
   # @wls_end.wdate = "#{params[:contract]['fendtime(4i)']}:#{params[:contract]['fendtime(5i)']}"
    @wls_end.save
  #  render inline: "<%= params.inspect %><br><br>" and return
    redirect_to root_path    
  end
  
 private  
    
  def contract_params
    params.require(:contract).permit(:cnum,:order_date,:flag,:car_id,:client_id,:user,:stdate,:sttime,:enddate,:endtime,:fendtime,:summ,:garant_summ,:costlei,:user_id,:zalog,:dperiod,:price,:curs)
  end
  
  def contract_init(contract)
    contract.cnum = (contract_params[:cnum]).lstrip.rstrip
    contract.order_date = contract_params[:order_date]
    contract.flag = contract_params[:flag]
    contract.car_id = if contract_params[:car_id].nil? then params[:car_id] else contract_params[:car_id] end
    contract.client_id = contract_params[:client_id]
    contract.user_id= contract_params[:user_id]
    contract.stdate = params[:stdate]
    contract.sttime = if (!contract_params['sttime(4i)'].nil? and !contract_params['sttime(5i)'].nil?) then "#{contract_params['sttime(4i)']}:#{contract_params['sttime(5i)']}" end
    contract.enddate = params[:enddate]
    contract.endtime = if (!contract_params['endtime(4i)'].nil? and !contract_params['endtime(5i)'].nil?) then "#{contract_params['endtime(4i)']}:#{contract_params['endtime(5i)']}" end
    contract.summ = params[:summ]
    contract.garant_summ = params[:garant_summ]
    contract.dperiod = params[:dperiod]
    contract.curs = params[:curs]
    contract.price = params[:price]
    contract.zalog = params[:zalog]
    contract.costlei = unless params[:costlei].nil? then params[:costlei] end
    contract    
  end
  
  def contract_save
    @flag = 0
    t = Contract.where("(? is null or id !=?) and flag in (1,2) and car_id = ? and ((stdate between ? and ?) or (enddate between ? and ?) or (? between stdate and enddate) or (? between stdate and enddate))", 
                       @contract.id, @contract.id, @contract.car_id, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate)
    c = Contract.where("(? is null or id !=?) and flag in (1,2) and car_id = ? and ((stdate between ? and ?) or (enddate between ? and ?) or (? between stdate and enddate) or (? between stdate and enddate))", 
                       @contract.id, @contract.id, @contract.car_id, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate).last                   
    if (!t.nil? and t.count != 0) then
      flash[:warning] = "Авто занято -  #{if c.flag==1 then 'Бронь' else 'Контракт' end} № #{c.id}/#{c.cnum} от #{c.order_date.strftime('%d.%m.%Y')} с #{c.stdate.strftime('%d.%m.%Y')} по #{c.enddate.strftime('%d.%m.%Y')}. Проверьте правильность ввода."        
    else
      begin
        if @contract.save! then 
          flash.discard
          flash[:notice] = "#{if @contract.flag==1 then 'Бронь' else 'Контракт' end} № #{@contract.id}/#{@contract.cnum} от #{@contract.order_date.strftime('%d.%m.%Y')} #{if @contract.flag==1 then 'сохранена' else 'сохранен' end}."
          @flag = 1         
        end
      rescue
        flash[:warning] = "Данные не сохранены. Проверьте правильность ввода."             
      end
    end      
  end 
  
  def client_params
    params.require(:client).permit(:name,:sname,:fname,:address,:pseria,:idno,:dn,:de,:tel,:bdate,:pemail,:comments)
  end
  
  def client_init(client)
    client.name = (client_params[:name]).lstrip.rstrip
    client.sname = (client_params[:sname]).lstrip.rstrip
    client.fname = (client_params[:fname]).lstrip.rstrip     
    client.address = client_params[:address]
    client.pseria = client_params[:pseria]
    client.idno = client_params[:idno]
    if params[:bdate].nil? or params[:bdate].empty? then client.bdate = nil else client.bdate = (params[:bdate].to_date).to_formatted_s(:dday_month_year) end
    if params[:dn].nil? or params[:dn].empty? then client.dn = nil else client.dn = (params[:dn].to_date).to_formatted_s(:dday_month_year) end
    client.de = client_params[:de]
    client.tel = client_params[:tel]
    client.pemail = client_params[:pemail]
    client.comments = client_params[:comments]
    client    
  end
  
  def client_save
    t = Client.where("(? is null or id !=?) and UPPER(sname) = ? and UPPER(name) = ? and UPPER(fname) = ? ", 
                      @client.id, @client.id, (@client.sname).upcase, (@client.name).upcase, (@client.fname).upcase).count
    c = Client.where("(? is null or id !=?) and UPPER(sname) = ? and UPPER(name) = ? and UPPER(fname) = ? ", 
                      @client.id, @client.id, (@client.sname).upcase, (@client.name).upcase, (@client.fname).upcase).last                      
    if (t != 0) then
      flash[:warning] = "Клиент № #{c.id} #{c.sname} #{c.name} #{c.fname} уже существует. Проверьте правильность ввода."            
    else
      begin
        if @client.save! then 
          flash.discard
          flash[:notice] = "Клиент #{@client.sname} #{@client.name} #{@client.fname} сохранен."
          @flag = 1         
        end
      rescue
        flash[:warning] = "Данные не сохранены. Проверьте правильность ввода."             
      end
    end      
  end
  
  def redirect_cancel
    if params[:editfromshow] then  redirect_to contracts_edit_path(:id => params[:id]) and return end
    #render inline: "<%= params.inspect %><br><br>" and return
    if params[:printfromshow] then  redirect_to contracts_show_path(:id => params[:id], format: "pdf") and return end     
    # when calcel
    if params[:cancel] then
      flash.discard
      #render inline: "<%= params.inspect %><br><br>" and return
      case when (params[:va] = 'broni2contract') then redirect_to root_path
           when (params[:va] == 'newbroni' or params[:flag] == '1') then redirect_to contracts_indexbroni_path 
           else redirect_to contracts_path 
      end
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
