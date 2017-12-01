class User < ActiveRecord::Base
  has_many :contracts, inverse_of: :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]
         
  attr_accessible :email, :password, :password_confirmation, 
  :remember_me, :username, :last_name, :profile_name ,:name,:surname,:bdate
          
end
