class Wlong < ActiveRecord::Base
  
  belongs_to :car
  belongs_to :tehservice, :class_name => 'Car' ,foreign_key: 'car_id'
  
  attr_accessible :wlong, :wdate, :manager
  
  validates :wlong, presence: true
  #validates :wdate, presence: true
  #validates :manager, presence: true
end
