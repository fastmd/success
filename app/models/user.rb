class User < ActiveRecord::Base
  has_many :contracts, inverse_of: :user
  has_many :tehservices, inverse_of: :user
  validates :username, presence: true, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, length: { minimum: 5, maximum: 50 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]
         
  attr_accessible :email, :password, :password_confirmation, 
  :remember_me, :username, :last_name, :profile_name ,:name,:surname,:bdate
          
end
