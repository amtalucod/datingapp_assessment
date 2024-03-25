class Booking < ApplicationRecord
    belongs_to :user
    belongs_to :hotel
    accepts_nested_attributes_for :user
    accepts_nested_attributes_for :hotel
    
  
end
