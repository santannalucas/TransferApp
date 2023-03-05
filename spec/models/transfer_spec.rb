require 'rails_helper'
require 'spec_helper'

RSpec.describe Transfer, type: :model do
  let(:from_account) { create(:account, initial_balance: 1000) }
  let(:to_account) { create(:account, initial_balance: 2000) }

  describe "validations" do
    it "requires a from_account" do
      transfer = Transfer.new(to_account: to_account, amount: 100)
      expect(transfer).to be_invalid
      expect(transfer.errors[:from_account]).to be_present
    end
  end


end