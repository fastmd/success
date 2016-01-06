class UserNotifier < ApplicationMailer
  
    default :from => 'sergelus@yandex.ru'

  # send a signup email to the user, pass in the user object that   contains the user's email address
   def welcome_email(mail,id)
    @user = mail
    @id = id
    @url  = "http://87.255.87.52:3000/login"
    mail(:to => @user, :subject => "Success supersite message")
  end

  
end
