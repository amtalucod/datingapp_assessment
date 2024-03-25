class Hotel < ApplicationRecord
    has_many :users, through: :bookings
    has_many :bookings
    accepts_nested_attributes_for :bookings
end
