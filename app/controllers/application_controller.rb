class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  before_action :authenticate_user!  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :rusdayofweek
  $GreenDelay = 12*60*60
  $valuta = "EUR"
  
  around_action :with_time_zone, if: 'current_user.try(:time_zone)'

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
  
  def set_header(p_type, filename)
  case p_type
    when 'xls'
     headers['Content-Type'] = "application/vnd.ms-excel; charset=UTF-8'"
     headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
     headers['Cache-Control'] = ''

    when 'msword'
     headers['Content-Type'] = "application/vnd.ms-word; charset=UTF-8"
     headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
     headers['Cache-Control'] = ''

   end
 end
 
 def rusdayofweek
  @day_week_ru = ""
  @day_week_ru = case Time.now.strftime("%A") when "Monday"    then "Понедельник" 
                                              when "Tuesday"   then "Вторник" 
                                              when "Wednesday" then "Среда"
                                              when "Thursday"  then "Четверг"
                                              when "Friday"    then "Пятница"
                                              when "Saturday"  then "Суббота"
                                              when "Sunday"    then "Воскресение" end      
 end
 
 def with_time_zone(&block)
    time_zone = current_user.time_zone
    logger.debug "Используется часовой пояс пользователя: #{time_zone}"
    Time.use_zone(time_zone, &block)
 end
  
end
