class Tehservice < ActiveRecord::Base  
  belongs_to :car, inverse_of: :tehservices
  belongs_to :user, inverse_of: :tehservices
  #has_many   :wlongs, through: :car, inverse_of: :tehservices
  has_one :wlong, inverse_of: :tehservice 
  
  validates :sdate, presence: true  
  validates :sprice, numericality: { allow_nil: true, :greater_than_or_equal_to => 0 }
  validates :car_id, presence: true, numericality: { only_integer: true }  
  validates :user_id, presence: true, numericality: { only_integer: true }    
end
