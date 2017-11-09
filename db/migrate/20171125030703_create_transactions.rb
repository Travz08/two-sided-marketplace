class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
      t.string :charge_id
      t.integer :amount

      t.timestamps
    end
  end
end
