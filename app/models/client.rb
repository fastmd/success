class Client < ActiveRecord::Base
  has_many :contracts, inverse_of: :client, foreign_key: "client_id", class_name: "Contract"
  has_many :contracts, inverse_of: :client2, foreign_key: "client2_id", class_name: "Contract"  
  validates :name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :sname, presence: true, length: { minimum: 2, maximum: 25 }
  validates :fname, length: { maximum: 25 }
end
