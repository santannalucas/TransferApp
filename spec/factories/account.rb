FactoryBot.define do
  factory :account do
    number { "1234567890123456" }
    initial_balance { 1000 }
  end
end