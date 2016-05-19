class Car < ActiveRecord::Base
  has_many :contracts
  has_many :wlongs
  has_many :tehservices

  
  accepts_nested_attributes_for :contracts, :wlongs, :tehservices
 
end
