require 'rails_helper'
require 'spec_helper'

RSpec.describe Transfer, type: :model do
  let(:from_account) { create(:account, number: 1234567812345678, initial_balance: 1000) }
  let(:to_account) { create(:account, number: 8765432187654321, initial_balance: 2000) }

  describe "validations" do
    it "requires a from_account" do
      transfer = Transfer.new(to_account: to_account, amount: 100)
      expect(transfer).to be_invalid
      expect(transfer.errors[:from_account]).to be_present
    end

    it "requires a to_account" do
      transfer = Transfer.new(from_account: from_account, amount: 100)
      expect(transfer).to be_invalid
      expect(transfer.errors[:to_account]).to be_present
    end

    it "requires an amount" do
      transfer = Transfer.new(from_account: from_account, to_account: to_account)
      expect(transfer).to be_invalid
      expect(transfer.errors[:amount]).to be_present
    end

    it "amount must be positive" do
      transfer = Transfer.new(from_account: from_account, to_account: to_account, amount: -100)
      expect(transfer).to be_invalid
      expect(transfer.errors[:amount]).to be_present
    end

    it "validations from_account must have enough balance to make the transfer" do
      transfer = Transfer.create(from_account: from_account, to_account: to_account, amount: 10000000)
      expect(transfer.errors[:from_account]).to include("does not have enough funds")
    end

  end

  describe "#save" do
    it "updates the balances of the accounts involved in the transfer" do
      transfer = Transfer.new(from_account: from_account, to_account: to_account, amount: 500)
      expect { transfer.save }.to change { from_account.reload.balance }.from(1000).to(500)
      .and change { to_account.reload.balance }.from(2000).to(2500)
    end
  end

end




