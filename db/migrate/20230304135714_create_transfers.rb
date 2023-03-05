class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.references :from_account, foreign_key: { to_table: :accounts }
      t.references :to_account, foreign_key: { to_table: :accounts }
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
