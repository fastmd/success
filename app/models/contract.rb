class Contract < ActiveRecord::Base
  belongs_to :client, class_name: "Client", inverse_of: :contracts, foreign_key: "client_id"
  belongs_to :client2, class_name: "Client", inverse_of: :contracts, foreign_key: "client2_id"#, optional: true
  belongs_to :car, inverse_of: :contracts
  belongs_to :user, inverse_of: :contracts
  has_many :wlongs, inverse_of: :contract
  #validates_associated :client
  #validates_associated :car 
  #validates_associated :user 
  
  validates :stdate, presence: true  
  validates :enddate, presence: true
  validates :car_id, presence: true, numericality: { only_integer: true }
  validates :client_id, presence: true, numericality: { only_integer: true }
  validates :client2_id, presence: false, numericality: { only_integer: true, allow_nil: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :flag, presence: true, numericality: { only_integer: true }
  
  accepts_nested_attributes_for :client, :allow_destroy => false, :reject_if  => :all_blank
  accepts_nested_attributes_for :client2, :allow_destroy => false, :reject_if  => :all_blank
end
