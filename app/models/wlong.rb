class Wlong < ActiveRecord::Base
  belongs_to :car, inverse_of: :wlongs
  belongs_to :contract, inverse_of: :wlongs
  belongs_to :tehservice, inverse_of: :wlong
  #has_many :tehservices, through: :car, inverse_of: :wlongs
  
  validates :parcurs, presence: true, numericality: { only_integer: true, allow_nil: false, :greater_than_or_equal_to => 0 }
  validates :wdate, presence: true  
end
