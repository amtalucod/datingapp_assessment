class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.string :name
      t.string :room_type
      t.date :check_in_date
      t.date :check_out_date

      t.timestamps
    end
  end
end
