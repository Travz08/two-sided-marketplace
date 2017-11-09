class Customer < ApplicationRecord
  belongs_to :user
  has_many :items
  geocoded_by :full_address
  after_validation :geocode
  include ImageUploader[:image]

  def self.search(search)
    where("first_name ILIKE ? OR last_name ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def full_address
    [country, city, address, postcode].compact.join(', ')
  end
end
