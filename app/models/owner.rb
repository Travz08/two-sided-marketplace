class Owner < ApplicationRecord
  belongs_to :user
  has_many :messages
  has_many :items
  geocoded_by :full_address
  after_validation :geocode

  def full_address
  [country, city, street].compact.join(‘, ‘)
  end
end
