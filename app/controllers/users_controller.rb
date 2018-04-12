class UsersController < ApplicationController
load_and_authorize_resource  
 # UserMailer.deliver_registration_confirmation(@user)
  
  def index
   if current_user.superadmin_role? then
     @users = User.all
   elsif  current_user.supervisor_role? then
     @users = User.where("superadmin_role is null or superadmin_role != 1")
   end       
  end
  
  def giveuserrole
   if current_user.superadmin_role? || current_user.supervisor_role? then
     @user = User.find(params[:id])
     if @user then
       sql = "update users set user_role=1, supervisor_role = 0, updated_at=datetime('now') where id = #{@user.id}"
       ActiveRecord::Base.connection.execute(sql)
       flash[:notice] = "Роль Оператор назначена для #{@user.username}."
     else
       flash[:warning] = "Нет пользователя с id=#{params[:id]}."  
     end
    redirect_to action: 'index'     
   end     
  end
  
  def givesupervisorrole
   if current_user.superadmin_role? || current_user.supervisor_role? then
     @user = User.find(params[:id])
     if @user then
       sql = "update users set user_role=0, supervisor_role = 1, updated_at=datetime('now') where id = #{@user.id}"
       ActiveRecord::Base.connection.execute(sql)
       flash[:notice] = "Роль Администратор назначена для #{@user.username}."
     else
       flash[:warning] = "Нет пользователя с id=#{params[:id]}."  
     end
    redirect_to action: 'index'     
   end     
  end
  
  def givenemorole
   if current_user.superadmin_role? || current_user.supervisor_role? then
     @user = User.find(params[:id])
     if @user then
       sql = "update users set user_role=0, supervisor_role = 0, nemo_role = 1, updated_at=datetime('now') where id = #{@user.id}"
       ActiveRecord::Base.connection.execute(sql)
       flash[:notice] = "Роль Немо назначена для #{@user.username}."
     else
       flash[:warning] = "Нет пользователя с id=#{params[:id]}."  
     end
    redirect_to action: 'index'     
   end     
  end  
  
 def dropallroles
   if current_user.superadmin_role? || current_user.supervisor_role? then
     @user = User.find(params[:id])
     if @user then
       sql = "update users set user_role = 0, supervisor_role = 0, nemo_role = 0, updated_at=datetime('now') where id = #{@user.id}"
       ActiveRecord::Base.connection.execute(sql)
       flash[:notice] = "Все роли удалены для #{@user.username}."
     else
       flash[:warning] = "Нет пользователя с id=#{params[:id]}."  
     end
    redirect_to action: 'index'     
   end     
  end
  
  def dropuser
   if current_user.superadmin_role? || current_user.supervisor_role? then
     user = User.find(params[:id])
     if user then
       usercontracts = user.contracts.count
       if usercontracts==0 then 
        sql = "delete from users where id = #{user.id}"
        ActiveRecord::Base.connection.execute(sql)
        flash[:notice] = "Пользователь #{user.username} удален."
       else
        flash[:warning] = "Нельзя удалить пользователя #{user.username}, у которого #{usercontracts} контрактов! Просто сделайте его Немо или пошлите его к черту."
       end
     else
       flash[:warning] = "Нет пользователя с id=#{params[:id]}."  
     end
    redirect_to action: 'index'     
   end      
  end
  
  def savenew
    sql = "insert into users (name,email, created_at,updated_at) values( 
          #{ActiveRecord::Base.connection.quote(user_params[:name])}, 
          #{ActiveRecord::Base.connection.quote(user_params[:email])},now(), now())"
    ActiveRecord::Base.connection.execute(sql)
    redirect_to action: 'index'
  end
    
end
