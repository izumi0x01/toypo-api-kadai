# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
    User.create!(
      email: "user#{n + 1}@example.com",
      name: "#{n + 1}太郎",
      password: "111111",
      password_confirmation: "111111",
    )
  end

  5.times do |n|
    Store.create!(
      email: "store#{n + 1}@example.com",
      name: "店舗#{n + 1}",
      address: "福岡県博多市#{n+1}丁目",
      password: "111111",
      password_confirmation: "111111",
    )
  end

  StampcardContent.create!(
    store_id: 1,
    max_stamp_count: 10,
  )
