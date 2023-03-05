require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "validations" do

    it "requires a number" do
      account = Account.new(initial_balance: 1000)
      expect(account).to be_invalid
      expect(account.errors[:number]).to be_present
    end

    it "initial_balance must be positive" do
      account = Account.new(number: 12345678, initial_balance: -1000)
      expect(account).to be_invalid
      expect(account.errors[:initial_balance]).to be_present
    end
  end

  describe "#balance" do
    it "returns the initial balance when the account is created" do
      account = Account.create(number: 12345678, initial_balance: 1000)
      expect(account.balance).to eq(1000)
    end

    it "returns the correct balance after a transfer is created" do
      from_account = Account.create(number: 1234567812345678, initial_balance: 1000)
      to_account = Account.create(number: 8765432187654321, initial_balance: 2000)
      Transfer.create(from_account: from_account, to_account: to_account, amount: 500)
      from_account.reload
      to_account.reload
      expect(from_account.balance).to eq(500)
      expect(to_account.balance).to eq(2500)
    end

  end
end