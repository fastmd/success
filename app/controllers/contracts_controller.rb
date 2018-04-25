class ContractsController < ApplicationController
  load_and_authorize_resource
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
    #---driver1-----------------------------------------------
    unless params[:active].nil? then
      @flag = 0
      @client = Client.new(client_params)
      @client = client_init(@client)
      client_save
      @contract.client = @client     
    else 
       if params[:contract][:client_attributes] then
         #render inline: "<%= params[:contract][:client_id].inspect %><br><br><%= @contract.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return  
         if params[:contract][:client_id].nil? or params[:contract][:client_id] == "" then
             @flag = 0
             @client = Client.new
             @client = contract_client_init(@client)
             @contract.client = @client
             if (@client.name!="" and @client.sname!="" and @client.name.length>3 and @client.sname.length>3) then
                #render inline: "новый <%= @contract.inspect %><br><br><%= @client.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return                 
                client_save
                @contract.client = @client
             else
                flash[:warning] = "Проверьте имя и фамилию клиента."
             end     
         else
             @oclient = @client = @contract.client
             @client = contract_client_init(@client)
             if (@client.sname != @oclient.sname) or (@client.name != @oclient.name) or (@client.address != @oclient.address) or (@client.pseria != @oclient.pseria) or (@client.idno != @oclient.idno) or
                (@client.dn != @oclient.dn) or (@client.de != @oclient.de) or (@client.tel != @oclient.tel) or (@client.bdate != @oclient.bdate) or (@client.pemail != @oclient.pemail) or
                (@client.comments != @oclient.comments) then
                   #render inline: "старый <%= @contract.inspect %><br><br><%= @client.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return
                   @flag = 0
                   @contract.client = @client
                   client_save
             end 
             #render inline: "<%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return   
         end
      end                      
    end
    if (@flag == 0) then
        gon.cars = Car.all
        gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)")       
        gon.clients = Client.all
        flash[:warning] = "Ошибка в клиенте."
        if params[:va] == 'newbroni'  then 
          render 'newbroni'  and return 
        else  
          render 'new'  and return
        end       
    end
    #---driver2-----------------------------------------------
    if params[:contract][:client2_attributes] then
         #render inline: "<%= params[:contract][:client_id].inspect %><br><br><%= @contract.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return  
         if params[:contract][:client2_id].nil? or params[:contract][:client2_id] == "" then
             @contract.client2_id = nil
             @client = Client.new
             @client = contract_client2_init(@client)
             if (@client.name.length>3 and @client.sname.length>3) then
                #render inline: "новый <%= @contract.inspect %><br><br><%= @client.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return                 
                @flag = 0
                @contract.client2 = @client
                client_save
                @contract.client2 = @client
             else
               if (@client.name!="" or @client.sname!="") then
                @contract.client2 = @client  
                @flag = 0
                flash[:warning] = "Проверьте имя и фамилию второго водителя."
               end 
             end     
         else
             @oclient = @client = @contract.client2
             @client = contract_client2_init(@client)
             if (@client.sname != @oclient.sname) or (@client.name != @oclient.name) or (@client.address != @oclient.address) or (@client.pseria != @oclient.pseria) or (@client.idno != @oclient.idno) or
                (@client.dn != @oclient.dn) or (@client.de != @oclient.de) or (@client.tel != @oclient.tel) or (@client.bdate != @oclient.bdate) or (@client.pemail != @oclient.pemail) or
                (@client.comments != @oclient.comments) then
                   #render inline: "старый <%= @contract.inspect %><br><br><%= @client.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return
                   @flag = 0
                   @contract.client2 = @client
                   client_save
             end 
             #render inline: "<%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return   
         end
    end
    if (@flag == 0) then
        gon.cars = Car.all
        gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)")       
        gon.clients = Client.all
        flash[:warning] = "Ошибка второго водителя."
        if params[:va] == 'newbroni'  then 
          render 'newbroni'  and return 
        else  
          render 'new'  and return
        end       
    end
    #---contract----------------------------------------------
    @flag = nil                     
    contract_save
    if (@flag == 0) then
        gon.cars = Car.all
        gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)")       
        gon.clients = Client.all
       # flash[:warning] = "Ошибка в контракте."
        if params[:va] == 'newbroni'  then 
          render 'newbroni'  and return 
        else  
          render 'new'  and return
        end       
    end
    #---parcurs-----------------------------------------------
    if (!params[:parcurs].nil? and params[:parcurs]!="" and @contract.flag == 2) then
      @wlong = Wlong.new
      @wlong = wlong_init(@wlong)    
      wlong_save 
      #render inline: "<%= @wlong.inspect %><br><br><%= @contract.inspect %><br><br><%= @flag.inspect %><br><br>" and return         
    end         
    #render inline: "<%= params.inspect %><br><br>" and return
    #---happyend-----------------------------------------------
    if params[:printfromedit] then  redirect_to contracts_show_path(:id => @contract.id, format: "pdf") and return end
    if params[:va] == 'newbroni'  then 
       redirect_to contracts_indexbroni_path 
    else 
       case @contract.flag when 3 then redirect_to contracts_indexarc_path
                           when 1 then redirect_to contracts_indexbroni_path 
                           else redirect_to contracts_path end
    end
  end
     
  def update
    #render inline: "<%= params.inspect %><br><br>" and return          
    @contract = Contract.find(params[:id])
    @stdate = @contract.stdate
    @fenddate = @contract.fenddate
    @contract = contract_init(@contract)
    #---driver1-----------------------------------------------
    unless params[:active].nil? then
      @flag = 0
      @client = Client.new(client_params)
      @client = client_init(@client)
      client_save
      @contract.client = @client     
    else 
       if params[:contract][:client_attributes] then
         #render inline: "<%= params[:contract][:client_id].inspect %><br><br><%= @contract.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return  
         if params[:contract][:client_id].nil? or params[:contract][:client_id] == "" then
             @flag = 0
             @client = Client.new
             @client = contract_client_init(@client)
             @contract.client = @client
             if (@client.name!="" and @client.sname!="" and @client.name.length>3 and @client.sname.length>3) then
                #render inline: "новый <%= @contract.inspect %><br><br><%= @client.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return                 
                client_save
                @contract.client = @client
             else
                flash[:warning] = "Проверьте имя и фамилию клиента."
             end     
         else
             @oclient = @client = @contract.client
             @client = contract_client_init(@client)
             if (@client.sname != @oclient.sname) or (@client.name != @oclient.name) or (@client.address != @oclient.address) or (@client.pseria != @oclient.pseria) or (@client.idno != @oclient.idno) or
                (@client.dn != @oclient.dn) or (@client.de != @oclient.de) or (@client.tel != @oclient.tel) or (@client.bdate != @oclient.bdate) or (@client.pemail != @oclient.pemail) or
                (@client.comments != @oclient.comments) then
                   #render inline: "старый <%= @contract.inspect %><br><br><%= @client.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return
                   @flag = 0
                   @contract.client = @client
                   client_save
             end 
             #render inline: "<%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return   
         end
      end                      
    end
    if (@flag == 0) then
        gon.cars = Car.all
        gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)")       
        gon.clients = Client.all
        flash[:warning] = "Ошибка в клиенте."
        render 'edit' and return       
    end
    #---driver2-----------------------------------------------
    if params[:contract][:client2_attributes] then
         #render inline: "<%= params[:contract][:client_id].inspect %><br><br><%= @contract.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return  
         if params[:contract][:client2_id].nil? or params[:contract][:client2_id] == "" then
             @contract.client2_id = nil
             @client = Client.new
             @client = contract_client2_init(@client)
             if (@client.name.length>3 and @client.sname.length>3) then
                #render inline: "новый <%= @contract.inspect %><br><br><%= @client.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return                 
                @flag = 0
                @contract.client2 = @client
                client_save
                @contract.client2 = @client
             else
               if (@client.name!="" or @client.sname!="") then
                @contract.client2 = @client  
                @flag = 0
                flash[:warning] = "Проверьте имя и фамилию второго водителя."
               end 
             end     
         else
             @oclient = @client = @contract.client2
             @client = contract_client2_init(@client)
             if (@client.sname != @oclient.sname) or (@client.name != @oclient.name) or (@client.address != @oclient.address) or (@client.pseria != @oclient.pseria) or (@client.idno != @oclient.idno) or
                (@client.dn != @oclient.dn) or (@client.de != @oclient.de) or (@client.tel != @oclient.tel) or (@client.bdate != @oclient.bdate) or (@client.pemail != @oclient.pemail) or
                (@client.comments != @oclient.comments) then
                   #render inline: "старый <%= @contract.inspect %><br><br><%= @client.inspect %><br><br><%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return
                   @flag = 0
                   @contract.client2 = @client
                   client_save
             end 
             #render inline: "<%= params[:contract].inspect %><br><br><%= params[:contract][:client_attributes].inspect %><br><br>" and return   
         end
    end
    if (@flag == 0) then
        gon.cars = Car.all
        gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)")       
        gon.clients = Client.all
        flash[:warning] = "Ошибка второго водителя."
        render 'edit' and return       
    end 
    #---parcurs-----------------------------------------------                  
    if (!params[:parcurs].nil? and params[:parcurs]!="" and @contract.flag == 2) then
      if Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @stdate).count != 0 then 
        @wlong = Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @stdate).last 
      else
        @wlong = Wlong.new
      end
      @wlong = wlong_init(@wlong)    
      wlong_save 
      #render inline: "<%= @wlong.inspect %><br><br><%= @contract.inspect %><br><br><%= @flag.inspect %><br><br>" and return         
    end
    @flag = nil
    if @contract.flag == 3 then
      @flag = 0
      if (!params[:parcurse].nil? and params[:parcurse]!="") then
        if Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @fenddate).count != 0 then 
          @wlong = Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @fenddate).last 
        else
          @wlong = Wlong.new
        end
        @wlong = wlong_init1(@wlong)    
        wlong_save 
        #render inline: "<%= @wlong.inspect %><br><br><%= @contract.inspect %><br><br><%= @flag.inspect %><br><br>" and return         
      end
    end 
    if (@flag == 0) then
        gon.cars = Car.all
        gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)")       
        gon.clients = Client.all
        flash[:warning] = "Введите пробег на конец!!!"
        render 'edit' and return       
    end     
    #---contract----------------------------------------------
    @flag = 0                     
    contract_save  
    if @flag == 1 then
      if params[:printfromedit] then  redirect_to contracts_show_path(:id => @contract.id, format: "pdf") and return end
      case @contract.flag when 1 then redirect_to contracts_indexbroni_path
                          when 3 then redirect_to contracts_indexarc_path 
                          else redirect_to contracts_path end
    else
      gon.cars = Car.all
      gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)") 
      gon.clients = Client.all                                     
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
          flash[:notice] = if contract.flag != 1 then "Контракт № #{contract.id}/#{contract.cnum} от #{contract.stdate.strftime('%d.%m.%Y')} удален." 
                           else "Бронь № #{contract.id}/#{contract.cnum} от #{contract.stdate.strftime('%d.%m.%Y')} удалена."end          
        end
      rescue
        flash[:warning] = if contract.flag != 1 then "Не удалось удалить контракт #{contract.id}/#{contract.cnum} от #{contract.stdate.strftime('%d.%m.%Y')}."
                          else "Не удалось удалить бронь #{contract.id}/#{contract.cnum} от #{contract.stdate.strftime('%d.%m.%Y')}." end              
      end
    end    
    case contract.flag when 1 then redirect_to contracts_indexbroni_path 
                       when 3 then  redirect_to contracts_indexarc_path
                       else redirect_to contracts_path end 
  end  
   
  def new
   gon.clients = Client.all 
   gon.cars = Car.all
   gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)")
   #render inline: "<%= @wlongs.inspect %><br><br><%= @wlongs.count.inspect %><br><br>" and return
   @contract = Contract.new
   @contract.car_id = params[:car_id]
   @contract.order_date =  Date.today
   @contract.stdate = params[:stdate] ?  params[:stdate] : Date.today
   d = @contract.stdate + 1.day
   @contract.enddate = d   
   @contract.dperiod = 1
   @contract.user_id = current_user.id
   @contract.flag = 2
   @contract.curs = Cparam.last.curs ? Cparam.last.curs : 1
   unless @contract.car_id.nil? then
     @car = @contract.car
     @contract.price = @car.int1price   # price     
     @contract.zalog = @car.gaj         # zalog 
     @contract.garant_summ = @car.gaj   # задаток
     unless @car.wlongs.last.nil? then @lastparcurs = @car.wlongs.last.parcurs end       # parcurs   
   end
   @pretperday = @contract.price.to_i
   @daysinperiod = @contract.dperiod
   # suma valuta
   @contract.summ = (@contract.price.to_i * @contract.dperiod).round(2) 
   # suma lei 
   @contract.costlei = ((@contract.price.to_i * @contract.dperiod).round(2) * @contract.curs.to_i).round(2)
   @contract.client = if params[:client_id] then Client.find(params[:client_id]) else Client.new end
   @contract.client2 = Client.new   
   #render inline: "<%= @contract.inspect %><br><br>"  
  end
  
  def newbroni
   gon.cars = Car.all
   gon.clients = Client.all
   gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)") 
   @contract = Contract.new
   @contract.car_id = params[:car_id]
   @contract.stdate = params[:stdate] ?  params[:stdate] : DateTime.now
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
   @contract.client = if params[:client_id] then Client.find(params[:client_id]) else Client.new end
   @contract.client2 = Client.new   
  # render inline: "<%= params.inspect %><br><br>"  
  end
    
  def edit
    gon.cars = Car.all
    gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)")
    gon.clients = Client.all                                  
    @contract = Contract.find(params[:id])
    @car = @contract.car
    if (!@contract.client2_id? and @contract.flag != 3)  then @contract.client2 = Client.new end
    unless @contract.client_id? then @contract.client = Client.new end  
    @clients = Client.all.order(:sname,:name,:fname)
    # parcurs 
    if Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.stdate).count!=0 then 
      @parcurs = Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.stdate).last.parcurs 
    else
      unless @car.wlongs.last.nil? then @lastparcurs = @car.wlongs.last.parcurs end       # parcurs 
    end
    if @contract.flag==3 and Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.fenddate).count!=0 then 
      @parcurse = Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.fenddate).last.parcurs 
    end
  end
  
  def show  
    @contract = Contract.find(params[:id])   
    @car = @contract.car
    @client = @contract.client
    if (!@contract.client2_id? and @contract.flag != 3)  then @contract.client2 = Client.new end
    unless @contract.client_id? then @contract.client = Client.new end  
      #render inline: "<%= @parcurs.inspect %><br><br>"  and return
    # parcurs 
    if Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.stdate).count!=0 then 
      @parcurs = Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.stdate).last.parcurs 
    else
      unless @car.wlongs.last.nil? then @lastparcurs = @car.wlongs.last.parcurs end       # parcurs
    end
    if @contract.flag==3 and Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.fenddate).count!=0 then 
      @parcurse = Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.fenddate).last.parcurs 
    end
    @daysinperiod = @contract.dperiod ? @contract.dperiod : (@contract.enddate.to_date - @contract.stdate.to_date).to_i   #number of days between report dates
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
    #render inline: "<%= params.inspect %><br><br>"  and return 
    gon.cars = Car.all
    gon.clients = Client.all
    gon.wlongs = Wlong.find_by_sql("SELECT t1.id, t1.car_id, t1.parcurs FROM (SELECT t.id, t.car_id, t.parcurs, max(wdate) wdate, updated_at  updated_at 
                                      FROM wlongs t group by t.car_id having t.wdate = max(wdate)) T1 group by t1.car_id having t1.updated_at = max(t1.updated_at)")    
    @contract = Contract.find(params[:id])
    @car = @contract.car
    @client = @contract.client
    unless @contract.client2_id? then @contract.client2 = Client.new end
    unless @contract.client_id? then @contract.client = Client.new end   
    # пробег
    unless @car.wlongs.last.nil? then @lastparcurs = @car.wlongs.last.parcurs end       # parcurs
    #render inline: "<%= @parcurs.inspect %><br><br>"  and return  
    # contract
    @contract.flag = 2
    # агент
    if @contract.user.nil? then @contract.user_id = current_user.id end
    # zalog
    @car = @contract.car
    @contract.zalog = @car.gaj
    # days in period
    @daysinperiod = @contract.dperiod ? @contract.dperiod : (@contract.enddate.to_date - @contract.stdate.to_date).to_i   #number of days between report dates
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
  end
  
  def contract2arh
    # contract
    @contract = Contract.find(params[:id])
    @contract.flag = 3
    d = @contract.enddate.to_datetime.in_time_zone   
    @contract.fenddate = d
    if @contract.user.nil? then @contract.user_id = current_user.id end
    @car = @contract.car
    @client = @contract.client
    unless @contract.client2_id? then @contract.client2 = Client.new end
    unless @contract.client_id? then @contract.client = Client.new end  
    # parcurs 
    if Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.stdate).count!=0 then 
      @parcurs = Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.stdate).last.parcurs 
    else
      unless @car.wlongs.last.nil? then @lastparcurs = @car.wlongs.last.parcurs end       # parcurs
    end
    if @contract.flag==3 and Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.fenddate).count!=0 then 
      @parcurse = Wlong.where("(contract_id is not null and contract_id= ? and car_id = ? AND wdate = ?)", @contract.id, @contract.car_id, @contract.fenddate).last.parcurs 
    end
    #render inline: "<%= @wlong.inspect %><br><br>" and return       
  end
  
 private  
  
  def wlong_init(wlong)
    wlong.parcurs = params[:parcurs]
    wlong.car_id = params[:car_id]
    wlong.contract_id = @contract.id
    d = (params[:stdate]).to_datetime.in_time_zone 
    unless (params['timebeg']['sttime(4i)'].nil?) then d = d.change(hour: params['timebeg']['sttime(4i)'].to_i) end
    unless (params['timebeg']['sttime(5i)'].nil?) then d = d.change(min: params['timebeg']['sttime(5i)'].to_i) end  
    wlong.wdate = d
    wlong    
  end
  
  def wlong_init1(wlong)
    wlong.parcurs = params[:parcurse]
    wlong.car_id = params[:car_id]
    wlong.contract_id = params[:id]
    d = (params[:fenddate]).to_datetime.in_time_zone 
    unless (params['ftimeend']['fendtime(4i)'].nil?) then d = d.change(hour: params['ftimeend']['fendtime(4i)'].to_i) end
    unless (params['ftimeend']['fendtime(5i)'].nil?) then d = d.change(min: params['ftimeend']['fendtime(5i)'].to_i) end  
    wlong.wdate = d
    wlong    
  end  
  
  def wlong_save
      @flag = 0 
      begin
        if @wlong.save! then 
          @flag = 1         
        end
      rescue
        flash[:warning] = "Пробег не сохранен. Проверьте правильность ввода."             
      end    
  end
    
  def contract_params
    params.require(:contract).permit(:cnum,:order_date,:flag,:car_id,:client_id,:client2_id,:user,:stdate,:enddate,:fenddate,:summ,:garant_summ,:costlei,:user_id,:zalog,:dperiod,:price,:curs,
                                     :sttime,:endtime,:fendtime,:place,:comment, client2_attributes: [:id,:name,:sname,:fname,:address,:pseria,:idno,:dn,:de,:tel,:bdate,:pemail,:comments])
  end
    
  def contract_init(contract)
    contract.cnum = (contract_params[:cnum]).lstrip.rstrip
    contract.order_date = contract_params[:order_date]
    contract.flag = contract_params[:flag]
    contract.comment = contract_params[:comment]
    contract.car_id = if contract_params[:car_id].nil? then params[:car_id] else contract_params[:car_id] end
    if (!contract_params[:client_id].nil? and contract_params[:client_id] != "")  then contract.client_id = contract_params[:client_id] else contract.client = Client.new end
    if contract_params[:client2_id] then contract.client2_id = contract_params[:client2_id] else contract.client2 = Client.new end
    contract.user_id= contract_params[:user_id]
    contract.place = contract_params[:place]
    # stdate
    if params[:stdate] then
      d = (params[:stdate]).to_datetime.in_time_zone 
      unless (params['timebeg']['sttime(4i)'].nil?) then d = d.change(hour: params['timebeg']['sttime(4i)'].to_i) end
      unless (params['timebeg']['sttime(5i)'].nil?) then d = d.change(min: params['timebeg']['sttime(5i)'].to_i) end  
      contract.stdate = d
    end
    # enddate
    if params[:enddate] then
      d = (params[:enddate]).to_datetime.in_time_zone 
      unless (params['timeend']['endtime(4i)'].nil?) then d = d.change(hour: params['timeend']['endtime(4i)'].to_i) end
      unless (params['timeend']['endtime(5i)'].nil?) then d = d.change(min: params['timeend']['endtime(5i)'].to_i) end
      #unless (params['timebeg']['sttime(4i)'].nil?) then d = d.change(hour: params['timebeg']['sttime(4i)'].to_i) end
      #unless (params['timebeg']['sttime(5i)'].nil?) then d = d.change(min: params['timebeg']['sttime(5i)'].to_i) end   
      contract.enddate = d
    end
    # fenddate
    if params[:fenddate] then
      d = (params[:fenddate]).to_datetime.in_time_zone 
      unless (params['ftimeend']['fendtime(4i)'].nil?) then d = d.change(hour: params['ftimeend']['fendtime(4i)'].to_i) end
      unless (params['ftimeend']['fendtime(5i)'].nil?) then d = d.change(min: params['ftimeend']['fendtime(5i)'].to_i) end  
      contract.fenddate = d
    end
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
    #render inline: "<%= params.inspect %><br><br>" and return
    @flag = 0
    if @contract.flag == 3 and (params[:parcurse].nil? or params[:parcurse]=='') then
      flash[:warning] = "Введите пробег на конец!!!"
    else 
    t = Contract.where("(? is null or id !=?) and car_id = ? and ((flag in (1,2) and ((stdate between ? and ?) or (enddate between ? and ?) or (? between stdate and enddate) or (? between stdate and enddate))) or (flag in (3) and ((stdate between ? and ?) or (fenddate between ? and ?) or (? between stdate and fenddate) or (? between stdate and fenddate))))", 
                       @contract.id, @contract.id, @contract.car_id, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate).count
    c = Contract.where("(? is null or id !=?) and car_id = ? and ((flag in (1,2) and ((stdate between ? and ?) or (enddate between ? and ?) or (? between stdate and enddate) or (? between stdate and enddate))) or (flag in (3) and ((stdate between ? and ?) or (fenddate between ? and ?) or (? between stdate and fenddate) or (? between stdate and fenddate))))", 
                       @contract.id, @contract.id, @contract.car_id, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate, @contract.stdate, @contract.enddate).last                   
    if (t != 0) then
      flash[:warning] = "Авто занято -  #{if c.flag==1 then 'Бронь' else 'Контракт' end} № #{c.id}/#{c.cnum} с #{c.stdate.strftime('%d.%m.%Y %R')} по #{c.enddate.strftime('%d.%m.%Y %R')}(#{c.enddate.strftime('%d.%m.%Y %R')}). Проверьте правильность ввода."        
    else
      begin
        if @contract.save! then 
          flash[:notice] = "#{if @contract.flag==1 then 'Бронь' else 'Контракт' end} № #{@contract.id}/#{@contract.cnum} от #{@contract.stdate.strftime('%d.%m.%Y')} #{if @contract.flag==1 then 'сохранена' else 'сохранен' end}."
          @flag = 1         
        end
      rescue
        flash[:warning] = "Данные не сохранены. Проверьте правильность ввода."             
      end
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
  
  def contract_client_init(client)
    client.name  = if !params[:contract][:client_attributes][:name].nil? and params[:contract][:client_attributes][:name] !="" then (params[:contract][:client_attributes][:name]).lstrip.rstrip else "" end
    client.sname = if !params[:contract][:client_attributes][:sname].nil? and params[:contract][:client_attributes][:sname]!="" then (params[:contract][:client_attributes][:sname]).lstrip.rstrip else "" end
    client.fname = if !params[:contract][:client_attributes][:fname].nil? and params[:contract][:client_attributes][:fname]!="" then (params[:contract][:client_attributes][:fname]).lstrip.rstrip  else "" end   
    client.address = params[:contract][:client_attributes][:address]
    client.pseria = params[:contract][:client_attributes][:pseria]
    client.idno = params[:contract][:client_attributes][:idno]
    if params[:contract_client_attributes_bdate].nil? or params[:contract_client_attributes_bdate].empty? then client.bdate = nil else client.bdate = (params[:contract_client_attributes_bdate].to_date).to_formatted_s(:dday_month_year) end
    if params[:contract_client_attributes_dn].nil? or params[:contract_client_attributes_dn].empty? then client.dn = nil else client.dn = (params[:contract_client_attributes_dn].to_date).to_formatted_s(:dday_month_year) end
    client.de = params[:contract][:client_attributes][:de]
    client.tel = params[:contract][:client_attributes][:tel]
    client.pemail = params[:contract][:client_attributes][:pemail]
    client.comments = params[:contract][:client_attributes][:comments]
    client    
  end
  
  def contract_client2_init(client)
    client.name  = if !params[:contract][:client2_attributes][:name].nil? and params[:contract][:client2_attributes][:name] !="" then (params[:contract][:client2_attributes][:name]).lstrip.rstrip else "" end
    client.sname = if !params[:contract][:client2_attributes][:sname].nil? and params[:contract][:client2_attributes][:sname]!="" then (params[:contract][:client2_attributes][:sname]).lstrip.rstrip else "" end
    client.fname = if !params[:contract][:client2_attributes][:fname].nil? and params[:contract][:client2_attributes][:fname]!="" then (params[:contract][:client2_attributes][:fname]).lstrip.rstrip  else "" end   
    client.address = params[:contract][:client2_attributes][:address]
    client.pseria = params[:contract][:client2_attributes][:pseria]
    client.idno = params[:contract][:client2_attributes][:idno]
    if params[:contract_client2_attributes_bdate].nil? or params[:contract_client2_attributes_bdate].empty? then client.bdate = nil else client.bdate = (params[:contract_client2_attributes_bdate].to_date).to_formatted_s(:dday_month_year) end
    if params[:contract_client2_attributes_dn].nil? or params[:contract_client2_attributes_dn].empty? then client.dn = nil else client.dn = (params[:contract_client2_attributes_dn].to_date).to_formatted_s(:dday_month_year) end
    client.de = params[:contract][:client2_attributes][:de]
    client.tel = params[:contract][:client2_attributes][:tel]
    client.pemail = params[:contract][:client2_attributes][:pemail]
    client.comments = params[:contract][:client2_attributes][:comments]
    client    
  end  
  
  def client_save
    t = Client.where("(? is null or id !=?) and UPPER(sname) = ? and UPPER(name) = ? and (fname is not null and UPPER(fname) = ? or fname is null and ? = '') ", 
                      @client.id, @client.id, (@client.sname).upcase, (@client.name).upcase, (@client.fname).upcase, @client.fname).count
    c = Client.where("(? is null or id !=?) and UPPER(sname) = ? and UPPER(name) = ? and (fname is not null and UPPER(fname) = ? or fname is null and ? = '') ", 
                      @client.id, @client.id, (@client.sname).upcase, (@client.name).upcase, (@client.fname).upcase, @client.fname).last                      
    if (t != 0) then
      flash[:warning] = "Клиент № #{c.id} #{c.sname} #{c.name} #{c.fname} уже существует. Проверьте правильность ввода."            
    else
      begin
        if @client.save! then 
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
    if params[:close] then  redirect_to contracts_contract2arh_path(:id => params[:id]) and return end  
    #render inline: "<%= params.inspect %><br><br>" and return
    if params[:printfromshow] then  redirect_to contracts_show_path(:id => params[:id], format: "pdf") and return end     
    # when calcel
    if params[:cancel] then
      #render inline: "<%= (params[:contract][:flag]).inspect %><br><br>" and return
      case when (params[:va] == 'broni2contract') then redirect_to root_path
           when (params[:va] == 'newbroni' or params[:flag] == '1') then redirect_to contracts_indexbroni_path
           when  params[:contract][:flag] == '3'  then redirect_to contracts_indexarc_path
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
