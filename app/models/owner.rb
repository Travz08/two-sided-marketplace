class Owner < ApplicationRecord
  belongs_to :user
  include ImageUploader[:image]
  has_many :items
  geocoded_by :address
  after_validation :geocode


end
