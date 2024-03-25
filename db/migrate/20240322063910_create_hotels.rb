class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels do |t|
      t.string :hotel_name
      t.string :description
      t.string :location
      t.string :contact_number
      t.string :amenities_string
      t.string :pricing

      t.timestamps
    end
  end
end
