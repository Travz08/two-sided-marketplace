json.extract! owner, :id, :profile_pic, :first_name, :last_name, :bio, :address, :city, :country, :postcode, :user_id, :created_at, :updated_at
json.url owner_url(owner, format: :json)
