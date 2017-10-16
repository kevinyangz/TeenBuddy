json.extract! client, :id, :fname, :lname, :home_address, :home_phone, :cell_phone, :created_at, :updated_at
json.url client_url(client, format: :json)
