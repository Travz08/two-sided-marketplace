class Item < ApplicationRecord
  include ImageUploader[:image]
  belongs_to :owner
end
