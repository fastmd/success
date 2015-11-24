class Wlong < ActiveRecord::Base
  
  belongs_to :car
  
  attr_accessible :wlong, :wdate, :manager
  
  validates :wlong, presence: true
  validates :wdate, presence: true
  #validates :manager, presence: true
end
