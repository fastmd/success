class Client < ActiveRecord::Base
  has_many :contract
  
  attr_accessible :name, :sname, :fname, :idno, :pseria, :dn, :de, :address, :tel, :pemail, :bdate
end
