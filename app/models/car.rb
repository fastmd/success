class Car < ActiveRecord::Base
  has_many :contracts, inverse_of: :car
  has_many :wlongs, inverse_of: :car
  has_many :tehservices, inverse_of: :car
  
  accepts_nested_attributes_for :contracts, :wlongs, :tehservices
  
  validates :marca, presence: true, length: { minimum: 2, maximum: 50 }
  validates :gnum, presence: true, length: { minimum: 2, maximum: 25 }
  validates :gaj, presence: true, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 }
  validates :int1, presence: true, numericality: { only_integer: true, allow_nil: false, :greater_than_or_equal_to => 0 } 
  validates :int1price, presence: true, numericality: { only_integer: true, allow_nil: false, :greater_than_or_equal_to => 0 }
  validates :int2, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 }  
  validates :int2price, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 } 
  validates :int3, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 }  
  validates :int3price, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 } 
  validates :int4, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 }   
  validates :int4price, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 } 
  validates :int5, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 }  
  validates :int5price, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 } 
  validates :int6, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 } 
  validates :int6price, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 }
  validates :int7, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 }  
  validates :int7price, presence: false, numericality: { only_integer: true, allow_nil: true, :greater_than_or_equal_to => 0 }
end
