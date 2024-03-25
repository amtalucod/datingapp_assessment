json.extract! booking, :id, :name, :room_type, :check_in_date, :check_out_date, :created_at, :updated_at
json.url booking_url(booking, format: :json)
