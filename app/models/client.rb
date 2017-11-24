class Client < ActiveRecord::Base
  has_many :contract 
  attr_accessible :name, :sname, :fname, :idno, :pseria, :dn, :de, :address, :tel, :pemail, :bdate, :comments
  validates :name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :sname, presence: true, length: { minimum: 2, maximum: 25 }
  validates :fname, length: { maximum: 25 }
end
