class CreateOwners < ActiveRecord::Migration[5.1]
  def change
    create_table :owners do |t|
      t.text :profile_pic
      t.string :first_name
      t.string :last_name
      t.string :bio
      t.string :address
      t.string :city
      t.string :country
      t.integer :postcode
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
