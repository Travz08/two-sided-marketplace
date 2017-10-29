json.extract! item, :id, :image_data, :caption, :owner_id, :created_at, :updated_at
json.url item_url(item, format: :json)
