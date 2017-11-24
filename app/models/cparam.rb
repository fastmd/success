class Cparam < ActiveRecord::Base
    validates :curs, presence: true, numericality: {greater_than: 0} 
    rails_admin do
    end
end
