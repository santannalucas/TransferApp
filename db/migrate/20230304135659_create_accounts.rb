class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :number, limit: 16
      t.decimal :balance, precision: 10, scale: 2, default: 0.0
      t.timestamps
    end
    add_index :accounts, :number, unique: true
  end
end
