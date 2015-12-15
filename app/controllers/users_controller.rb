class UsersController < ApplicationController
  
  UserMailer.deliver_registration_confirmation(@user)
  
end
