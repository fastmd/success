class UserMailer < ApplicationMailer
  
     default :from => 'sergelus@yandex.ru'

 layout "mailer"
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_email(email,id)
    recipients  user.email
  from        "sergelus@yandex.ru"
  subject     "Thank you for Registering"
  body        :user => email
  end

  
end
