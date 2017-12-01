class Car < ActiveRecord::Base
  has_many :contracts, inverse_of: :car
  has_many :wlongs, inverse_of: :car
  has_many :tehservices, inverse_of: :car
  
  accepts_nested_attributes_for :contracts, :wlongs, :tehservices
  
  validates :marca, presence: true, length: { minimum: 2, maximum: 25 }
  validates :gnum, presence: true, length: { minimum: 2, maximum: 25 }
 
end
