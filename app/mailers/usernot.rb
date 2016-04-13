class Usernot < ApplicationMailer
  
  default :from => 'sergelus@yandex.ru'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_email(posta,id)
    @cont_id = id
    mail( :to => posta,
    :subject => ' Contract №' + id.to_s + ' is opened' , :text => ' Contract №' + id.to_s + ' is opened' )
     @id = id
  end

  
end
