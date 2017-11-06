class Customer < ApplicationRecord
  belongs_to :user
  has_many :messages
  geocoded_by :address
  after_validation :geocode
  include ImageUploader[:image]
  def full_address
  [country, city, address, postcode].compact.join(', ')
  end
end
