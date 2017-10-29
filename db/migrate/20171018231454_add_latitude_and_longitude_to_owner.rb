class AddLatitudeAndLongitudeToOwner < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :latitude, :float
    add_column :owners, :longitude, :float
  end
end
