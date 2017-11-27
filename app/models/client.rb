class Client < ActiveRecord::Base
  has_many :contract 
  validates :name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :sname, presence: true, length: { minimum: 2, maximum: 25 }
  validates :fname, length: { maximum: 25 }
end
