class Car < ActiveRecord::Base
  has_many :contracts
  has_many :wlongs
  
  accepts_nested_attributes_for :contracts, :wlongs
end
