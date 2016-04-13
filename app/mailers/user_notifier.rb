class UserNotifier < ApplicationMailer
  
    default :from => 'sergelus@yandex.ru'
 layout "mailer"
  # send a signup email to the user, pass in the user object that   contains the user's email address
   def welcome_email(mail,id)
    @user = mail
    @id = id
    @url  = "http://127.0.0.1:3000/login"
    mail(:to => @user, :subject => "Success supersite message")
  end

  
end
