FactoryBot.define do
  factory :store do
    
    store_name { "StoreA" }
    store_description {"I am the storeA"}
    sequence(:email){|n| "store#{n}@example.com"}
    password {"pw"}

  end
end
