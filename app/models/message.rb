class Message < ApplicationRecord
  belongs_to :owner
  belongs_to :customer
end
