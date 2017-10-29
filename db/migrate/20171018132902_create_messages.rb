class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :owner, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
