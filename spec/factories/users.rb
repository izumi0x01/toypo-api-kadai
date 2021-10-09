require "date"

FactoryBot.define do
  factory :user do
    first_name { "山田" }
    last_name {"太郎"}
    sequence(:email) { |n| "example#{n}@example.com" } 
    birth{Time.current}
    password { "111111" }
  end
end