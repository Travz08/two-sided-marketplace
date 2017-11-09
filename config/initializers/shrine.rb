require 'cloudinary'
require 'shrine/storage/cloudinary'

Cloudinary.config(
  cloud_name: ENV['CLOUD_NAME'],
  api_key:    ENV['API_KEY'],
  api_secret: ENV['API_SECRET']
)




Shrine.storages = {
  cache: Shrine::Storage::Cloudinary.new(resource_type: 'image'), # for direct uploads
  store: Shrine::Storage::Cloudinary.new(resource_type: 'image')
}
