class Owner < ApplicationRecord
  belongs_to :user
  include ImageUploader[:image]
  has_many :items
  geocoded_by :full_address
  after_validation :geocode

  def self.search(search)
    where("first_name LIKE ? OR last_name LIKE ?", "%#{search}%", "%#{search}%")
  end
  
  def full_address
    [country, city, address, postcode].compact.join(', ')
  end
end
