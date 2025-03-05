FactoryBot.define do
  factory :user do
    name { "Peter parker" }
    email_address { "peter@parker.com" }
    password { "password" }
    balance { 100.0 }
  end
end
