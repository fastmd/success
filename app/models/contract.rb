class Contract < ActiveRecord::Base
  belongs_to :client, inverse_of: :contracts
  belongs_to :car, inverse_of: :contracts
  belongs_to :user, inverse_of: :contracts
  #validates_associated :client
  #validates_associated :car 
  #validates_associated :user 
  
  validates :stdate, presence: true  
  validates :enddate, presence: true
  validates :car_id, presence: true, numericality: { only_integer: true }
  validates :client_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :flag, presence: true, numericality: { only_integer: true }
  
end
