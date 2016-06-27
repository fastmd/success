class CarsController < ApplicationController
  autocomplete :client, :pseria , :extra_data => [:sname],:extra_data => [:fname],:full => true
  def index
   @cars = Car.all
    i = 0;
    j = 0;
    @buz = []
    @dd = []
     @cars.each do |ca|
      ca.contracts.each do |co|
        @dd[i] = co.order_date.to_s.to_s + ","
        @buz[i] = @buz[i].to_s + co.order_date.to_s[8..9].to_s + ","   
    end
    i = i + 1
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
    
     if Contract.maximum(:id) != nil
      conmax = Contract.maximum(:id)
     else 
      conmax = 0
     end
         
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
   end
  
  def rezdoc
    num = params[:car_num]
    
    @car = Car.find(num)
    @contract = @car.contracts.create
    @client = Client.find(params[:cli_id])
    
         if Contract.maximum(:id) != nil
      conmax = Contract.maximum(:id)
     else 
      conmax = 0
     end
         
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
    
     if Contract.maximum(:id) != nil
      conmax = Contract.maximum(:id)
     else 
      conmax = 0
     end
         
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
  end
  
  def show    
    @car = Car.find(params[:id])
  end
  
  def autotech
    @cars = Car.all
  end
 
  def smonth
    
    if params[:num]
        mnum = params[:num]
    else
        mnum = Date.today.to_s[5..6].to_i
        
    end 
    if (mnum.to_i % 2)
      @daycount = 31
    else
      @daycount = 30
      
    end
        
    @cars = Car.all
    i = 0;
    j = 0;
    
    @mn = mnum
    @buz = []
    @buz1 = []
    @buz2 = []
    @dd = []
    @qord = []
    j = 0
     @cars.each do |ca|
      ca.contracts.each do |co|
        mon = co.order_date.to_s[5..6]
        if mon.to_i == mnum.to_i  
          @qord[j] = ca.id
          j = j + 1
          @qord[j] = co.id.to_s
          j = j+1
          @qord[j] = co.flag.to_s
          j = j+1
          @qord[j] = co.order_date.to_s
          j = j + 1
          @qord[j] = co.diff.to_s
          j = j+1
          @dd[i] = co.order_date.to_s + ","
          stdate = co.order_date.to_s[8..9].to_i
          @buz[i] = co.order_date.to_s[8..9].to_s
          diff = (co.diff.to_s[0..1].to_i+1) - stdate    
          @buz1[i] = diff.to_s
          @buz2[i] = co.flag
        end
        i = i + 1     
    end
    i = i + 1
    @buz[i] = ""
    end
  end
  
 
    def user_params
      params.require(:user).permit(:first_name, :last_name, :other_stuff)
    end 
  
end
