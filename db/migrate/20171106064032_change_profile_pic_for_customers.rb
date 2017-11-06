class ChangeProfilePicForCustomers < ActiveRecord::Migration[5.1]
  def change
    rename_column :customers, :profile_pic, :image_data
  end
end
