class AddHotelIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :hotel_id, :integer
    add_index :bookings, :hotel_id
  end
end
