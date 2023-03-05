class Account < ApplicationRecord
  has_many :transfers_from, class_name: "Transfer", foreign_key: "from_account_id", dependent: :destroy
  has_many :transfers_to, class_name: "Transfer", foreign_key: "to_account_id", dependent: :destroy

  validates :number, presence: true, uniqueness: true
  validates :initial_balance, numericality: { greater_than_or_equal_to: 0 }

  def balance
    initial_balance + transfers_to.sum(:amount) - transfers_from.sum(:amount)
  end

end