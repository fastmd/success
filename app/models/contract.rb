class Contract < ActiveRecord::Base
  belongs_to :client
  belongs_to :car
  
  attr_accessible :cnum, :order_date, :diff, :client, :user
  
  validates :cnum, presence: true
  validates :order_date, presence: true
  validates :diff, presence: true
  
end
