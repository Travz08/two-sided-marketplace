class ChangeProfilePicForOwners < ActiveRecord::Migration[5.1]
  def change
    rename_column :owners, :profile_pic, :image_data
  end
end
