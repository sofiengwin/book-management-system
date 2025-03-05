FactoryBot.define do
  factory :transaction do
    user { nil }
    book { nil }
    borrowed_at { Time.now }
    returned_at { nil }
    fee_charged { "9.99" }
  end
end
