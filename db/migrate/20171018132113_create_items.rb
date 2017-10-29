class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.text :image_data
      t.string :caption
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
