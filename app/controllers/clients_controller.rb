class ClientsController < ApplicationController
 before_action :redirect_cancel, only: [:create, :update]
  
 def new  
 end
  
 def create
  @client = Client.new(client_params)
  @client = client_init(@client)
  client_save
  if @flag == 1 then
    redirect_to clients_path
  else
    render 'new'     
  end      
 end
  
 def show
  @client = Client.find(params[:id])
 end
  
 def edit
  @client = Client.find(params[:id])
 end 
  
 def update  
    @client = Client.find(params[:id])
    @client = client_init(@client)
    client_save
    if @flag == 1 then
      redirect_to clients_path
    else
      render 'edit'
    end
 end
 
 def destroy
    client = Client.find(params[:id])
    ss_count = client.contracts.count
    if ss_count!=0 then 
      flash[:warning] = "Нельзя удалить клиента #{client.id} #{client.sname} #{client.name} #{client.fname}, для которого существуют контракты (#{ss_count} шт.)" 
    else 
      begin
        if client.destroy! then 
          flash.discard
          flash[:notice] = "Клиент #{client.id} #{client.sname} #{client.name} #{client.fname} удален."         
        end
      rescue
        flash[:warning] = "Не удалось удалить клиента #{client.id} #{client.sname} #{client.name} #{client.fname}."             
      end
    end
    redirect_to clients_index_path
 end    
   
 def index
    @clients = Client.all.order(sname: :desc, name: :desc, fname: :desc, bdate: :desc)
    @client = Client.new
 end
 
 private
 
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
    @flag = 0
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
          flash[:notice] = "Клиент #{@client.sname} #{@client.name} сохранен."
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
      redirect_to clients_index_path
    end   
  end     

end
