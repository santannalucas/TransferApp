class Transfer < ApplicationRecord
  belongs_to :from_account, class_name: "Account"
  belongs_to :to_account, class_name: "Account"

  validates :from_account, presence: true
  validates :to_account, presence: true
  validates :amount, numericality: { greater_than: 0 }, presence: true
  validate :validate_sufficient_funds

  scope :account, -> (account_id) {where("from_account_id = ? OR to_account_id = ?", account_id, account_id)}

  def validate_sufficient_funds
    if from_account_id && Account.exists?(from_account_id) && amount.present?
      from_account = Account.find(from_account_id)
      if from_account.balance < amount
        errors.add(:from_account, "does not have enough funds") if from_account.balance < amount
      end
    end
  end


end