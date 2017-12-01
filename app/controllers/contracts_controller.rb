class ContractsController < ApplicationController
  before_action :redirect_cancel, only: [:create, :update]
  
  def index
    @contracts = Contract.where("(flag = 2)").order(:order_date)
  end
  
  def indexbroni
    @contracts = Contract.where("(flag = 1)").order(:order_date)
  end
  
  def indexarc
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
      if params[:va] == 'newbroni' then redirect_to contracts_indexbroni_path else redirect_to contracts_path end
    else
      render 'new'     
    end 
    #render inline: "<%= params.inspect %><br><br>"
  end
     
  def update  
    @contract = Contract.find(params[:id])
    @contract = contract_init(@contract)
    contract_save
    if @flag == 1 then
      if @contract.flag == 1 then redirect_to contracts_indexbroni_path else redirect_to contracts_path end
    else
      render 'edit'
    end
    #render inline: "<%= params.inspect %><br><br>"
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
   @contract = Contract.new
   @contract.client_id = params[:client_id]
   @contract.car_id = params[:car_id]
 #  render inline: "<%= @contract.inspect %><br><br>"  
  end
  
  def newbroni
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
   @contract = Contract.new
   @contract.client_id = params[:client_id]
   @contract.car_id = params[:car_id]
   @contract.stdate = params[:stdate]
 #  render inline: "<%= @contract.inspect %><br><br>"  
  end
    
  def edit
    @carints =  [Array.new(12), Array.new(12),Array.new(12), Array.new(12),Array.new(12), Array.new(12)] 
    i = 1
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
    @contract = Contract.find(params[:id])
  end
  
  def show    
    @contract = Contract.find(params[:id])
    @car = @contract.car
    @client = @contract.client
    mmail = "octa_c@moldelectrica.md;sergelus@yandex.ru"
    #Usernot.send_email(mmail,@contract.id).deliver
    @contract.id do |format|
      format.html # show.html.erb
      format.xml { render :xml => @item }    
      format.pdf do
          render :pdf => 'Coming soon...', :layout => false
      end
    end
  end
  
  def broni2contract
    @contract = Contract.find(params[:contract_id]) 
    @contract.flag = 2
 #   @contract.enddate = params[:enddate]
    @contract.endtime = "#{params[:contract]['endtime(4i)']}:#{params[:contract]['endtime(5i)']}"
    @contract.sttime = "#{params[:contract]['sttime(4i)']}:#{params[:contract]['sttime(5i)']}"
    @contract.summ = params[:summ]
    @contract.garant_summ = params[:garant_summ]
    contract_save
    @car = @contract.car
    @car.wlongs.create()
    @wls = @car.wlongs.last
    @wls.wlong = params[:wlong]
    @wls.wdate = "#{params[:contract]['endtime(4i)']}:#{params[:contract]['endtime(5i)']}"
    @wls.save
    if @flag == 1 then
      redirect_to root_path
    else
      render 'cars/smonth'     
    end         
  end
  
  def contract2arh
    @contract = Contract.find(params[:contract_id])
    @contract.flag = 3
    @contract.fendtime = "#{params[:contract]['fendtime(4i)']}:#{params[:contract]['fendtime(5i)']}"
    if @contract.user.nil? then @contract.user_id = current_user.id end
    contract_save
    @car = @contract.car
    @wls_end = @car.wlongs.create()
    @wls_end.wlong = params[:contract][:wlongend]
    @wls_end.wdate = "#{params[:contract]['fendtime(4i)']}:#{params[:contract]['fendtime(5i)']}"
    @wls_end.save
    #render inline: "<%= params.inspect %><br><br>"
    if @flag == 1 then
      redirect_to root_path
    else
      render 'cars/smonth'     
    end     
  end
  
 private  
    
  def contract_params
    params.require(:contract).permit(:cnum,:order_date,:flag,:car_id,:client_id,:user,:stdate,:sttime,:enddate,:endtime,:fendtime,:summ,:garant_summ,:costlei,:user_id)
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
    contract.garant_summ = contract_params[:garant_summ]
    contract.costlei = if contract_params[:costlei].nil? then
                           if params[:summ].nil? then nil else (params[:summ].to_f * Cparam.last.curs).round(2) end 
                       else contract_params[:costlei].round(2) end
    contract    
  end
  
  def contract_save
    @flag = 0
    t = Contract.where("(? is null or id !=?) and flag in (1,2) and car_id = ? and ((stdate between ? and ?) or (enddate between ? and ?) or (? between stdate and enddate) or (? between stdate and enddate))", 
                       @contract.id, @contract.id, @contract.car_id, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate)
    c = Contract.where("(? is null or id !=?) and flag in (1,2) and car_id = ? and ((stdate between ? and ?) or (enddate between ? and ?) or (? between stdate and enddate) or (? between stdate and enddate))", 
                       @contract.id, @contract.id, @contract.car_id, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate).last                   
    if (!t.nil? and t.count != 0) then
      flash[:warning] = "Авто занято -  #{if c.flag==1 then 'Бронь' else 'Контракт' end} № #{c.id} / #{c.cnum} от #{c.order_date.strftime('%d.%m.%Y')} с #{c.stdate.strftime('%d.%m.%Y')} по #{c.enddate.strftime('%d.%m.%Y')}. Проверьте правильность ввода."        
    else
      begin
        if @contract.save! then 
          flash.discard
          @contract.save!
          flash[:notice] = "#{if @contract.flag==1 then 'Бронь' else 'Контракт' end} № #{@contract.id} / #{@contract.cnum} от #{@contract.order_date.strftime('%d.%m.%Y')} #{if @contract.flag==1 then 'сохранена' else 'сохранен' end}."
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
    if params[:cancel] then
      flash.discard
      #render inline: "<%= params.inspect %><br><br>" and return
      if params[:va] == 'newbroni' or params[:flag] == '1' then redirect_to contracts_indexbroni_path else redirect_to contracts_path end
    end   
  end          
    
end
