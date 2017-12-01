class Client < ActiveRecord::Base
  has_many :contracts, inverse_of: :client  
  validates :name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :sname, presence: true, length: { minimum: 2, maximum: 25 }
  validates :fname, length: { maximum: 25 }
end
