class Tehservice < ActiveRecord::Base
  
  belongs_to :car
  has_many :wlongs 
  
  attr_accessible :id, :sdate, :manager,:stype,:sprice
  
end
