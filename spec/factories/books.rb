FactoryBot.define do
  factory :book do
    title { "Oliver Twist" }
    author { "Charles Dickens" }
    genre { "Fiction" }
    isbn { "978-3-16-148410-0" }
  end
end
