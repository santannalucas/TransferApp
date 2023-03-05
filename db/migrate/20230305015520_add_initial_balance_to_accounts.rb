class AddInitialBalanceToAccounts < ActiveRecord::Migration[7.0]
  def change
    rename_column :accounts, :balance, :initial_balance
  end
end
