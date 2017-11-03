json.extract! post_application, :id, :post_id, :teenager_id,:message, :created_at, :updated_at
json.url post_application_url(post_application, format: :json)
