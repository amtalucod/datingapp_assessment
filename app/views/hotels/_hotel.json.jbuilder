json.extract! hotel, :id, :hotel_name, :description, :location, :contact_number, :amenities, :pricing, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
