class ClientsController < ApplicationController
  
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
    t = Client.where("UPPER(sname) = ? and UPPER(name) = ? and UPPER(fname) = ? ", (@client.sname).upcase, (@client.name).upcase, (@client.fname).upcase).count
    if (t != 0 and @client.id.nil?) then
      flash[:warning] = "Такой объект уже существует. Проверьте правильность ввода."        
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

end
